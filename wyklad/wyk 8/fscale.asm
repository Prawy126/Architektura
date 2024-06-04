         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

a        equ __?float64?__(2.0)
b        equ __?float64?__(3.14)

         call getaddr

addr_a   dq a  ;
addr_b   dq b  ; addr_b = addr_a + 8

getaddr:

;        esp -> [addr_a][ret]

         mov ebp, [esp]  ; ebp = *(int*)esp = addr_a

         finit
         
;        st = []

         fld qword [ebp+8]  ; *(double*)(ebp+8) = *(double*)addr_b = b -> st
         fld qword [ebp]    ; *(double*)(ebp+0) = *(double*)addr_a = a -> st

;        st = [st0, st1] = [a, b]

         fscale  ; [st0, st1] => [st0 * 2^[st1], st1] = [a * 2^[b], b]

;        st = [st0, st1] = [a * 2^[b], b]

         sub esp, 2*2*4  ; esp = esp - 16

;        esp -> [ ][ ][ ][ ][ret]

         call getaddr2
format:
         db "st0 = %f", 0xA
         db "st1 = %f", 0xA, 0
getaddr2:

;                       +4    +12
;        esp -> [format][ ][ ][ ][ ][ret]

         fstp qword [esp+4]   ; *(double*)(esp+4)  <- st = a * 2^[b]
         fstp qword [esp+12]  ; *(double*)(esp+12) <- st = b

;        st = []

         call [ebx+3*4]  ; printf(format, a*2^b, b);
         add esp, 5*4    ; esp = esp + 20

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


