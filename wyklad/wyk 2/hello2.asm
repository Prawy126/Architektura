         [bits 32]

extern   _printf
extern   _exit

global   _main

section  .text

_main:

;        esp -> [ret]  ; return address

         push format  ; *(int*)(esp-4) = format ; esp = esp - 4

;        esp -> [format][ret]

         call _printf  ; printf("Hello world!\n");

         add esp, 4  ; esp = esp + 4

;        esp -> [ret]

         push 0      ; esp -> [0][ret]
         call _exit  ; exit(0);
         
format   db "Hello world!", 0xA, 0

%ifdef COMMENT
Kompilacja:

nasm hello2.asm -o hello2.o -f win32

ld hello2.o -o hello2.exe c:\windows\system32\msvcrt.dll -m i386pe

lub:

nasm hello2.asm -o hello2.o -f win32

gcc hello2.o -o hello2.exe -m32
%endif
