         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         sub esp, 2*4  ; esp = esp - 8

;        esp -> [ ][ ][ret]

         call getaddr
format:
         db "PI = %.15f", 0xA, 0
getaddr:

;                       +4
;        esp -> [format][ ][ ][ret]

         finit  ; fpu init
         
;        st = []         

         fldpi  ; fpu load pi

;        st = [st0] = [pi]

         fstp qword [esp+4]  ; *(double*)(esp+4) <- st = pi

;        st = []
;                       +4
;        esp -> [format][pi_l][pi_h][ret]

         call [ebx+3*4]  ; printf("PI = %.15f\n", pi);
         add esp, 3*4    ; esp = esp + 12

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0)

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
