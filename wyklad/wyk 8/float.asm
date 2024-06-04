         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

a        equ __?float32?__(3.14)

         mov eax, a  ; eax = a

         push eax

;        esp -> [a][ret]

         finit
         
;        st = []         

         fld dword [esp]  ; *(float*)esp = a -> st = [a]

;        st = [st0] = [a]

         sub esp, 2*4  ; esp = esp - 8

;        esp -> [ ][ ][a][ret]

         call getaddr

format   db "float value = %f", 0xA, 0

getaddr:

;                       +4
;        esp -> [format][ ][ ][a][ret]

         fstp qword [esp+4]  ; *(double*)(esp+4) <- st = a

;        st = []
;                       +4
;        esp -> [format][a_l][a_h][a][ret]

         call [ebx+3*4]  ; printf(format, *(double*)(esp+4));
         add esp, 4*4    ; esp = esp + 16

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
