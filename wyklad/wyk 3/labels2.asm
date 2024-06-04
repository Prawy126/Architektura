         [bits 32]

;        esp -> [ret]  ; ret - return address

extern   _printf
extern   _exit

section  .data

format   db "label1 = %p", 0xA
         db "label2 = %p", 0xA, 0

section  .text

global   _main

_main    jmp skip

label1   dd 1  ; [01 00 00 00]
label2   dd 2  ; [02 00 00 00]

skip     push label2
         push label1

;        esp -> [label1][label2][ret]

         push format

;        esp -> [format][label1][label2][ret]

         call _printf  ; printf(format, label1, label2);
         add esp, 3*4  ; esp = esp + 12

;        esp -> [ret]

         push 0      ; esp -> [0][ret]
         call _exit  ; exit(0);

%ifdef COMMENT

Kompilacja:

nasm labels2.asm -o labels2.o -f win32
ld labels2.o -o labels2.exe c:\windows\system32\msvcrt.dll -m i386pe

lub:

nasm labels2.asm -o labels2.o -f win32
gcc labels2.o -o labels2.exe -m32

- ktory sposob kompilacji daje mniejszy rozmiar pliku wynikowego?

%endif