%ifdef COMMENT
Z: a != 0

a*x^2 + b*x + c = 0

delta = b*b - 4*a*c

P1: delta < 0

brak pierwiastkow

P2: delta = 0

x0 = -b / (2*a)

P3: delta > 0

x1 = (-b - sqrt(delta)) / (2*a)
x2 = (-b + sqrt(delta)) / (2*a)
%endif

         [bits 32]

;        esp -> [ret] ; ret - adres powrotu do asmloader

a        equ 2
b        equ 4
c        equ 4

         call getaddr  ; get the runtime address of format

addr_4   dd 4
addr_a   dd a  ; addr_a = addr_4 + 4
addr_b   dd b  ; addr_b = addr_4 + 8
addr_c   dd c  ; addr_c = addr_4 + 12

getaddr:

;        esp -> [addr_4][ret]

         mov eax, [esp]  ; eax = *(int*)esp = addr_4

         finit  ; fpu init
         
;        st = []

         fild dword [eax+8]  ; *(int*)(eax+8) = *(int*)addr_b = b -> st ; fpu load integer

;        st = [st0] = [b]
         
         fld st0  ; [st0] => [st0, st0] = [b, b]

;        st = [st0, st1] = [b, b]

         fmulp st1  ; [st0, st1] => [st0, st1*st0] => [st0*st1] = [b*b]

;        st = [st0] = [b*b]

         fild dword [eax]     ; *(int*)(eax)    = *(int*)addr_4 = 4 -> st ; fpu load integer
         fild dword [eax+4]   ; *(int*)(eax+4)  = *(int*)addr_a = a -> st ; fpu load integer
         fild dword [eax+12]  ; *(int*)(eax+12) = *(int*)addr_c = c -> st ; fpu load integer

;        st = [st0, st1, st2, st3] = [c, a, 4, b*b]

         fmulp st1  ; [st0, st1, st2, st3] => [st0, st1*st0, st2, st3] => [st1*st0, st2, st3] = [a*c, 4, b*b]

;        st = [st0, st1, st2] = [a*c, 4, b*b]

         fmulp st1  ; [st0, st1, st2] => [st0, st1*st0, st2] => [st1*st0, st2] = [4*a*c, b*b]

;        st = [st0, st1] = [4*a*c, b*b]

         fsubp st1  ; [st0, st1] => [st0, st1 - st0] => [st1 - st0] = [b*b - 4*a*c]

;        st = [st0] = [b*b - 4*a*c] = [delta]

         ftst  ; st0 - 0 ; C1=0 C0 C2 C3 affected ; fpu test st0

         mov esi, eax  ; esi = eax ; store eax

         fstsw ax  ; ax = fpu_status_word ; fpu store status word

         sahf  ; eflags(SF:ZF:0:AF:0:PF:1:CF) = ah

         mov eax, esi  ; eax = esi ; restore eax

         jae nieujemna  ; jump if above or equal ; jump if CF = 0 or ZF = 1

;        delta < 0

         call getaddr2
format:
         db "brak pierwiastkow", 0xA, 0
getaddr2:

;        esp -> [format][addr_4][ret]

         jmp print

nieujemna:

         ja dodatnia  ; jump if above ; jump if CF = 0 and ZF = 0

;        delta = 0

;        addr_4 nie jest juz potrzebny

         sub esp, 4  ; esp = esp - 4

;        esp -> [ ][ ][ret]

         call getaddr3
format2:
         db "x0 = %f", 0xA, 0
getaddr3:

;                        +4
;        esp -> [format2][ ][ ][ret]

;        st = [st0] = [0]

         fisub dword [eax+8]  ; [st0] => [st0 - *(int*)(eax+8)] = [-b]

;        st = [st0] = [-b]

         fld1  ; fpu load 1
         fld1  ; fpu load 1

;        st = [st0, st1, st2] = [1, 1, -b]

         faddp st1  ; [st0, st1, st2] => [st0, st1 + st0, st2] => [st1 + st0, st2] = [2, -b]

;        st = [st0, st1] = [2, -b]

         fild dword [eax+4]  ; *(int*)(eax+4) = *(int*)addr_a = a -> st ; fpu load integer

;        st = [st0, st1, st2] = [a, 2, -b]

         fmulp st1  ; [st0, st1, st2] => [st0, st1*st0, st2] => [st1*st0, st2] = [2*a, -b]

;        st = [st0, st1] = [2*a, -b]

         fdivp st1  ; [st0, st1] => [st0, st1 / st0] => [st1 / st0] = [-b / (2*a)]

;        st = [st0] = [-b / (2*a)]

         fstp qword [esp+4]  ; *(double*)(esp+4) <- st = -b / (2*a)

;        st = []

         jmp print

dodatnia:

;        delta > 0

;        addr_4 nie jest juz potrzebny

         sub esp, 3*4  ; esp = esp - 12

;        esp -> [ ][ ][ ][ ][ret]

         call getaddr4
format3:
         db "x1 = %f", 0xA
         db "x2 = %f", 0xA, 0
getaddr4:

;                        +4    +12
;        esp -> [format3][ ][ ][ ][ ][ret]

;        st = [st0] = [delta]

         fsqrt  ; [st0] => [sqrt(st0)] = [sqrt(delta)]

;        st = [st0] = [sqrt(delta)]

         fld1  ; fpu load 1
         fld1  ; fpu load 1

;        st = [st0, st1, st2] = [1, 1, sqrt(delta)]

         faddp st1  ; [st0, st1, st2] => [st0, st1 + st0, st2] => [st1 + st0, st2] = [2, sqrt(delta)]

;        st = [st0, st1] = [2, sqrt(delta)]

         fild dword [eax+4]  ; *(int*)(eax+4) = *(int*)addr_a = a -> st ; fpu integer load

;        st = [st0, st1, st2] = [a, 2, sqrt(delta)]

         fmulp st1  ; [st0, st1, st2] => [st0, st1*st0, st2] => [st1*st0, st2] = [2*a, sqrt(delta)]

;        st = [st0, st1] = [2*a, sqrt(delta)]

         fild dword [eax+8]  ; *(int*)(eax+8) = *(int*)addr_b = b -> st ; fpu integer load

;        st = [st0, st1, st2] = [b, 2*a, sqrt(delta)]

         fchs  ; [st0, st1, st2] => [-st0, st1, st2] = [-b, 2*a, sqrt(delta)]

;        st = [st0, st1, st2] = [-b, 2*a, sqrt(delta)]

         fld st0  ; [st0, st1, st2] => [st0, st0, st1, st2] = [-b, -b, 2*a, sqrt(delta)]

;        st = [st0, st1, st2, st3] = [-b, -b, 2*a, sqrt(delta)]

         fsub st3  ; [st0, st1, st2, st3] => [st0-st3, st1, st2, st3] = [-b-sqrt(delta), -b, 2*a, sqrt(delta)]

;        st = [st0, st1, st2, st3] = [-b - sqrt(delta), -b, 2*a, sqrt(delta)]

         fdiv st2  ; [st0, st1, st2, st3] => [st0 / st2, st1, st2, st3]

;        st = [st0, st1, st2, st3] = [(-b - sqrt(delta)) / (2*a), -b, 2*a, sqrt(delta)]

         fstp qword [esp+4]  ; *(double*)(esp+4) <- st = [x1, -b, 2*a, sqrt(delta)]

;        st = [st0, st1, st2] = [-b, 2*a, sqrt(delta)]

         fadd st2  ; [st0, st1, st2] => [st0+st2, st1, st2] = [-b+sqrt(delta), 2*a, sqrt(delta)]

;        st = [st0, st1, st2] = [-b + sqrt(delta), 2*a, sqrt(delta)]

         fdiv st1  ; [st0, st1, st2] => [st0 / st1, st1, st2]

;        st = [st0, st1, st2] = [(-b + sqrt(delta)) / (2*a), 2*a, sqrt(delta)]

         fstp qword [esp+12]  ; *(double*)(esp+4) <- st = [x2, 2*a, sqrt(delta)]

;        st = [st0, st1] = [2*a, sqrt(st0)]

print:

         call [ebx+3*4] ; printf(format, ...);
         add esp, 2*4   ; esp = esp + 8

;        esp -> [ret]

         push 0         ; esp -> [0][ret]
         call [ebx+0*4] ; exit(0);

