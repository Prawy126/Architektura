         [bits 32]

extern   _printf
extern   _exit

a        equ 1
b        equ 2
c        equ 3
d        equ 4

section  .data

addr_b   dd b  ; [02 00 00 00]  ; define double word
addr_c   dd c  ; [03 00 00 00]
addr_d   dd d  ; [04 00 00 00]

format   db "eax = %d", 0xA
         db "ebp = %p", 0xA
         db "ebx = %d", 0xA
         db "ecx = %d", 0xA
         db "edx = %d", 0xA, 0

section  .text

global   _main

_main:

;        esp -> [ret]

         mov eax, a         ; eax = a              ; instruction register, constant
         mov ebp, addr_b    ; ebp = addr_b         ; instruction register, memory
         mov ebx, [addr_b]  ; ebx = *(int*)addr_b  ; instruction register, memory

         mov esi, c         ; esi = c              ; instruction register, constant
         mov ecx, esi       ; ecx = esi = c        ; instruction register, register

         mov edi, 1                  ; edi = 1
         mov edx, [ebp + edi*4 + 4]  ; edx = *(int*)(ebp + edi*4 + 4) = *(int*)addr_d

;        [ Base_Reg + Index_Reg * Scale + Constant ]  Scale = 1,2,4,8

         push edx
         push ecx
         push ebx
         push ebp
         push eax
         
         push format

;        esp -> [format][eax][ebx][ebp][ecx][edx][ret]

         call _printf  ; printf(format);
         add esp, 6*4  ; esp = esp + 24

;        esp -> [ret]

         push 0      ; esp -> [0][ret]
         call _exit  ; exit(0);

%ifdef COMMENT
Kompilacja:

nasm mov.asm -o mov.o -f win32

ld mov.o -o mov.exe c:\windows\system32\msvcrt.dll -m i386pe

lub:

nasm mov.asm -o mov.o -f win32

gcc mov.o -o mov.exe -m32
%endif


