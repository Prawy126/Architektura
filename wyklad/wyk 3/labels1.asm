         [bits 32]

;        esp -> [ret]  ; ret - return address

         jmp skip

label1   dd 1  ; [01 00 00 00]
label2   dd 2  ; [02 00 00 00]

skip     push label2
         push label1

;        esp -> [label1][label2][ret]

         call getaddr
format:
         db "label1 = %p", 0xA
         db "label2 = %p", 0xA, 0
getaddr:

;        esp -> [format][label1][label2][ret]

         call [ebx+3*4]  ; printf(format, label1, label2);
         add esp, 3*4    ; esp = esp + 12

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