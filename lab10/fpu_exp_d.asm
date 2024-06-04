         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

;        exp = a*b + c*d = 4*5 + 6*7 = 62

         sub esp, 2*4 ; esp = esp - 8

;        esp -> [][][ret]

         call getaddr  ; push on the stack the runtime address of format and jump to that address
format:
         db "wynik = %f", 0xA, 0
length   equ $-format

addr_a   dq 4.0
addr_b   dq 5.0
addr_c   dq 6.0

getaddr:

;                       +4
;        esp -> [format][ ][ ][ret]

         finit  ; fpu init

         mov eax, [esp]   ; eax = *(int*)esp
         add eax, length  ; eax = eax + length = format

         fld qword [eax]    ; *(int*)eax = *(int*)addr_a = a -> st ; fpu load integer
         fld qword [eax+8]  ; *(int*)eax = *(int*)addr_b = b -> st ; fpu load integer
         fld qword [eax+16] ; *(int*)eax = *(int*)addr_c = c -> st ; fpu load integer

;        st = [st0, st1, st2] = [c, b, a]

         fmulp st1  ; [st0, st1, st2] => [st0, st0 * st1, st2] => [st0 * st1, st2] => [b*c, a]

;        st = [st0, st1] = [b*c, a]

         faddp st1  ; [st0, st1] => [st0, st1+st0] => [st1+st0] = [a + b*c]

;        st = [st0] = [a + b*c]

         fstp qword [esp+4]

;        st = []

         call [ebx+3*4]  ; printf(format, st1);
         add esp, 3*4    ; esp = esp + 4

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

%ifdef COMMENT

ebx    -> [ ][ ][ ][ ] -> exit
ebx+4  -> [ ][ ][ ][ ] -> putchar
ebx+8  -> [ ][ ][ ][ ] -> getchar
ebx+12 -> [ ][ ][ ][ ] -> printf
ebx+16 -> [ ][ ][ ][ ] -> scanf

%endif
