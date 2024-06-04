         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

a        equ __?float32?__(3.14)

         call getaddr

addr_a   dd a  ; [ ][ ][ ][ ]   define double word

getaddr:

;        esp -> [addr_a][ret]

         mov ebp, [esp]  ; ebp = *(int*)esp = addr_a
         
         finit
         
;        st = []                  

         fld dword [ebp]  ; *(float*)ebp = *(float*)addr_a = a -> st = [a]

;        st = [st0] = [a]

         sub esp, 2*4

;        esp -> [ ][ ][addr_a][ret]

         call getaddr2

format   db "a = %f", 0xA, 0

getaddr2:

;                       +4
;        esp -> [format][ ][ ][addr_a][ret]

         fstp qword [esp+4]  ; *(double*)(esp+4) <- st = a

;        st = []
;                       +4
;        esp -> [format][a_l][a_h][addr_a][ret]

         call [ebx+3*4]  ; printf(format, a);
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
