         [bits 32]

extern   _printf
extern   _exit

section  .text

global   _main

_main:

;        esp -> [ret]

         push _main

;        esp -> [_main][ret]

         push format

;        esp -> [format][_main][ret]

         call _printf  ; printf(format);
         add esp, 2*4  ; esp = esp + 8

;        esp -> [ret]

         push 0      ; esp -> [0][ret]
         call _exit  ; exit(0);
         
format   db "main = %p", 0xA, 0

%ifdef COMMENT
Kompilacja:

nasm main.asm -o main.o -f win32

ld main.o -o main.exe c:\windows\system32\msvcrt.dll -m i386pe

lub:

nasm main.asm -o main.o -f win32

gcc main.o -o main.exe -m32
%endif

