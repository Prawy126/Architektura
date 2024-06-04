         [bits 32]

;        esp -> [ret]

extern   _printf
extern   _exit

global   _main

section  .text

_main:

         push format

;        esp -> [format][ret]

         call _printf  ; print(format);

         push format2

;        esp -> [format2][format][ret]

         call _printf  ; print(format2);

         add esp, 2*4  ; esp = esp + 8

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call _exit

format   db "Hello world!", 0xA, 0
format2  db "Czy Ala ma kota?", 0xA, 0

%ifdef COMMENT
nasm strings.asm -o strings.o -f win32

ld strings.o -o strings.exe c:\windows\system32\msvcrt.dll -m i386pe

lub

nasm strings.asm -o strings.o -f win32

gcc strings.o -o strings.exe -m32
%endif

