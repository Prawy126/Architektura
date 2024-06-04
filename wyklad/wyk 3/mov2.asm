         [bits 32]

extern   _printf
extern   _exit

a        equ 1
b        equ 2
c        equ 3
d        equ 4
e        equ 5

section  .bss

addr_a   resd 1  ; [?? ?? ?? ??]  reserve double word
addr_b   resd 1  ; [?? ?? ?? ??]
addr_c   resd 1  ; [?? ?? ?? ??]
addr_d   resd 1  ; [?? ?? ?? ??]
addr_e   resd 1  ; [?? ?? ?? ??]

section .data

format   db "a = %d", 0xA
         db "b = %d", 0xA
         db "c = %d", 0xA
         db "d = %d", 0xA
         db "e = %d", 0xA, 0

section  .text

global   _main

_main:

;        esp -> [ret]

         mov dword [addr_a], a  ; *(int*)(addr_a) = a             ; instruction memory, constant

         mov ebx, b         ; ebx = b
         mov [addr_b], ebx  ; *(int*)(addr_b) = ebx = b           ; instruction memory, register

         mov ecx, addr_c     ; ecx = addr_c
         mov dword [ecx], c  ; *(int*)ecx = *(int*)addr_c = c     ; instruction memory, constant

         mov esi, d       ; esi = d
         mov edx, addr_d  ; edx = addr_d
         mov [edx], esi   ; *(int*)edx = *(int*)addr_d = esi = d  ; instruction memory, register

         mov edi, 2                        ; edi = 2
         mov eax, addr_a                   ; eax = addr_a
         mov dword [eax + edi*4 + 2*4], e  ; *(int*)(eax + edi*4 + 2*4) = *(int*)addr_e = e

;        [ Base_Reg + Index_Reg * Scale + Constant ]  Scale = 1,2,4,8

         push dword [addr_e]  ; *(int*)(esp-4) = *(int*)addr_e = e ; esp = esp - 4
         push dword [addr_d]  ; *(int*)(esp-4) = *(int*)addr_d = d ; esp = esp - 4
         push dword [addr_c]  ; *(int*)(esp-4) = *(int*)addr_c = c ; esp = esp - 4
         push dword [addr_b]  ; *(int*)(esp-4) = *(int*)addr_b = b ; esp = esp - 4
         push dword [addr_a]  ; *(int*)(esp-4) = *(int*)addr_a = a ; esp = esp - 4

;        esp -> [a][b][c][d][e][ret]

         push format

;        esp -> [format][a][b][c][d][e][ret]

         call _printf  ; printf(format);
         add esp, 6*4  ; esp = esp + 24

;        esp -> [ret]

         push 0      ; esp -> [0][ret]
         call _exit  ; exit(0);

%ifdef COMMENT
Kompilacja:

nasm mov2.asm -o mov2.o -f win32

ld mov2.o -o mov2.exe c:\windows\system32\msvcrt.dll -m i386pe

lub:

nasm mov2.asm -o mov2.o -f win32

gcc mov2.o -o mov2.exe -m32
%endif

