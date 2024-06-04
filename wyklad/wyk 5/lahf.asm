         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         lahf  ; ah = eflags(SF:ZF:0:AF:0:PF:1:CF) ; load AH from flags

         sahf  ; eflags(SF:ZF:0:AF:0:PF:1:CF) = ah ; store AH into flags

         movzx eax, ah  ; eax = 0:ah

         mov ecx, 8  ; ecx = 8

petla    shr eax, 1  ; CF = eax & 1 ; eax = eax >> 1 ; shift logical right

         mov edx, 0  ; edx = 0
         adc edx, 0  ; edx = 0 + CF

         push edx    ; edx -> stack

         loop petla

;        esp -> [8 values][ret]

         call getaddr
format:
         db 0xA
         db "07  06  05  04  03  02  01  00  bit", 0xA
         db "SF  ZF      AF      PF      CF  flag", 0xA
         db "%u   %u   %u   %u   %u   %u   %u   %u   value", 0xA, 0
getaddr:

;        esp -> [format][8 values][ret]

         call [ebx+3*4]  ; printf(format, ...);
         add esp, 9*4    ; esp = esp + 9*4

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
