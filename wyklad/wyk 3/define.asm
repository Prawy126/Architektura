         [bits 32]

extern   _printf
extern   _exit

a        equ 1
b        equ 2
c        equ 3
d        equ 4

section  .data

addr_a   db a  ; [01]                       ; define byte
addr_b   dw b  ; [02 00]                    ; define word
addr_c   dd c  ; [03 00 00 00]              ; define double word
addr_d   dq d  ; [04 00 00 00 00 00 00 00]  ; define quadruple word

format   db "a = %d", 0xA
         db "b = %d", 0xA
         db "c = %d", 0xA
         db "d = %lld", 0xA, 0

section  .text

global   _main

_main:

;        esp -> [ret]

         mov al, [addr_a]  ; al = *(char*)addr_a = a
         movzx eax, al     ; eax = 0:al

         mov bx, [addr_b]  ; bx = *(short*)addr_b = b
         movzx ebx, bx     ; ebx = 0:bx

         mov ecx, [addr_c]  ; ecx = *(int*)addr_c = c

         mov esi, [addr_d]    ; esi = *(int*)addr_d
         mov edi, [addr_d+4]  ; edi = *(int*)(adddr_d+4)

         push edi
         push esi

         push ecx
         push ebx
         push eax

;        esp -> [eax][ebx][ecx][esi][edi][ret]

         push format

;        esp -> [format][eax][ebx][ecx][esi][edi][ret]

         call _printf  ; printf(format, eax, ebx, ecx, edi:esi);
         add esp, 6*4  ; esp = esp + 24

;        esp -> [ret]

         push 0      ; esp -> [0][ret]
         call _exit  ; exit(0);

%ifdef COMMENT
Kompilacja:

nasm define.asm -o define.o -f win32

ld define.o -o define.exe c:\windows\system32\msvcrt.dll -m i386pe

lub:

nasm define.asm -o define.o -f win32

gcc define.o -o define.exe -m32
%endif

