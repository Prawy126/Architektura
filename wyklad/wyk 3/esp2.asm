         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         push esp  ; *(int*)(esp-4) = esp ; esp = esp - 4

;        esp -> [esp+4][ret]

         call getaddr
format:
         db "esp = %p", 0xA, 0
getaddr:

;                       +4     +8
;        esp -> [format][esp+4][ret]

         call [ebx+3*4]  ; printf("esp = %p\n", *(esp+4));
         add esp, 2*4    ; esp = esp + 8

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
; To co funkcja zwr�ci jest w EAX.
; Po wywolaniu funkcji sciagamy argumenty ze stosu.
;
; https://gynvael.coldwind.pl/?id=387

