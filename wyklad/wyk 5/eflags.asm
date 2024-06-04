         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         pushf  ; esp = esp - 4 ; *(int*)esp = eflags ; push eflags onto stack

;        esp -> [eflags][ret]

         mov eax, [esp]  ; eax = *(int*)esp = eflags

         popf  ; eflags = *(int*)esp ; esp = esp + 4 ; pop eflags from stack

;        esp -> [ret]

         mov ecx, 0   ; ecx = 0

petla    bt eax, ecx  ; CF = eax >> ecx & 1 ; bit test

         mov edx, 0   ; edx = 0
         adc edx, 0   ; edx = 0 + CF

         push edx     ; edx -> stack

         inc ecx      ; ecx = ecx + 1

         cmp ecx, 31  ; ecx - 31               ; OF SF ZF AF PF CF affected
         jbe petla    ; jump if below or equal ; jump if CF = 1 or ZF = 1

;        esp -> [32 values][ret]

         call getaddr
format:
         db 0xA
         db "31  30  29  28  27  26  25  24  23  22  21  20  19  18  17  16  bit", 0xA
         db "                                        ID  VIP VIF AC  VM  RF  flag", 0xA
         db "%u   %u   %u   %u   %u   %u   %u   %u   %u   %u   %u   %u   %u   %u   %u   %u   value", 0xA
         db 0xA
         db "15  14  13  12  11  10  09  08  07  06  05  04  03  02  01  00  bit", 0xA
         db "    NT  IOPL    OF  DF  IF  TF  SF  ZF      AF      PF      CF  flag", 0xA
         db "%u   %u   %u   %u   %u   %u   %u   %u   %u   %u   %u   %u   %u   %u   %u   %u   value", 0xA, 0
getaddr:

;        esp -> [format][32 values][ret]

         call [ebx+3*4]  ; printf(format, ...);
         add esp, 33*4   ; esp = esp + 33*4

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
