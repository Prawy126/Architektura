         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         finit
         
;        st = []

         fldz  ; 0 -> st ; fpu load zero

;        st = [st0] = [0]

         ftst ; st0 - 0 ; C1=0 C0 C2 C3 affected ; fpu test st0

         fstsw ax  ; ax = fpu_status_word ; fpu store status word

         mov ecx, 0   ; ecx = 0

petla    bt eax, ecx  ; CF = eax >> ecx & 1 ; bit test

         mov edx, 0   ; edx = 0
         adc edx, 0   ; edx = 0 + CF

         push edx     ; edx -> stack

         inc ecx      ; ecx = ecx + 1

         cmp ecx, 15  ; ecx - 15               ; OF SF ZF AF PF CF affected
         jbe petla    ; jump if below or equal ; jump if CF = 1 or ZF = 1

;        esp -> [16 values][ret]

         call getaddr
format:
         db 0xA
         db "15  14  13  12  11  10  09  08  07  06  05  04  03  02  01  00  bit", 0xA
         db "B   C3  TOP         C2  C1  C0  ES  SF  PE  UE  OE  ZE  DE  IE  flag", 0xA
         db "%u   %u   %u   %u   %u   %u   %u   %u   %u   %u   %u   %u   %u   %u   %u   %u   value", 0xA
         db 0xA
         db "    ZF              PF  1   CF  eflag", 0xA
         db "07  06  05  04  03  02  01  00  bit", 0xA, 0
getaddr:

;        esp -> [format][16 values][ret]

         call [ebx+3*4]  ; printf(format, ...);
         add esp, 17*4   ; esp = esp + 17*4

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0);

; asmloader API
;
; ESP wskazuje na prawidlowy stos
; argumenty funkcji wrzucamy na stos
; EBX zawiera pointer na tablice API
;
; call [ebx + NR_FUNKCJI*4] ; wywolanie funkcji API
;
; NR_FUNKCJI:
;
; 0 - exit
; 1 - putchar
; 2 - getchar
; 3 - printf
; 4 - scanf
;
; To co funkcja zwróci jest w EAX.
; Po wywolaniu funkcji sciagamy argumenty ze stosu.
;
; https://gynvael.coldwind.pl/?id=387
