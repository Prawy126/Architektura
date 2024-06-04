         [bits 32]

extern   _printf
extern   _exit

a        equ 1
b        equ 2
c        equ 3
d        equ 4

section  .bss

addr_a   resb 1  ; [00]                       ; reserve byte
addr_b   resw 1  ; [00 00]                    ; reserve word
addr_c   resd 1  ; [00 00 00 00]              ; reserve double word
addr_d   resq 1  ; [00 00 00 00 00 00 00 00]  ; reserve quadruple word

section  .data

format   db "a = %d", 0xA
         db "b = %d", 0xA
         db "c = %d", 0xA, 0

section  .text

global   _main

_main:

;        esp -> [ret]

         mov byte  [addr_a], a  ; *(char*)addr_a = a
         mov word  [addr_b], b  ; *(short*)addr_b = b
         mov dword [addr_c], c  ; *(int*)addr_c = c

         mov al, [addr_a]  ; al = *(char*)addr_a = a
         movzx eax, al     ; eax = 0:al

         mov bx, [addr_b]  ; bx = *(short*)addr_b = b
         movzx ebx, bx     ; ebx = 0:bx

         mov ecx, [addr_c]  ; ecx = *(int*)addr_c = c
         
         push ecx
         push ebx
         push eax

;        esp -> [eax][ebx][ecx][ret]

         push format

;        esp -> [format][eax][ebx][ecx][ret]

         call _printf  ; printf(format, eax, ebx, ecx);
         add esp, 4*4  ; esp = esp + 16

;        esp -> [ret]

         push 0      ; esp -> [0][ret]
         call _exit  ; exit(0);

%ifdef COMMENT
Kompilacja:

nasm reserve.asm -o reserve.o -f win32

ld reserve.o -o reserve.exe c:\windows\system32\msvcrt.dll -m i386pe

lub:

nasm reserve.asm -o reserve.o -f win32

gcc reserve.o -o reserve.exe -m32
%endif

