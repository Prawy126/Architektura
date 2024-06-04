         [bits 32]

extern   _printf
extern   _scanf
extern   _exit

section  .data

format   db "a = ", 0
format2  db "%d", 0
format3  db "a = %d",0xA, 0

section  .text

global   _main

_main:

;        esp -> [ret]  ; return address

         push format  ; *(int*)(esp - 4) = format ; esp = esp - 4
         
;        esp -> [format][ret]  ; return address

         call _printf  ; printf(format);
         
;        esp -> [a][ret]

         push esp

;        esp -> [addr_a][a][ret]

         push format2
         
;        esp -> [format2][addr_a][a][ret]

         call _scanf  ; scanf("%d", &a);
         add esp, 2*4  ; esp = esp + 8
         
;        esp -> [a][ret]

         push format3
         
;        esp -> [format3][a][ret]

         call _printf  ; printf(format3, a);
         add esp, 2*4  ; esp = esp + 8
         
;        esp -> [ret]

         push 0      ; esp ->[00 00 00 00][ret]
         call _exit  ; exit(0);

%ifdef COMMENT
Kompilacja:

nasm hello2.asm -o hello2.o -f win32
ld hello2.o -o hello2.exe c:\windows\system32\msvcrt.dll -m i386pe

lub:

nasm hello2.asm -o hello2.o -f win32
gcc hello2.o -o hello2.exe -m32
%endif
