         [bits 32]

extern   _printf
extern   _scanf
extern   _exit

section  .data

format   db "a = ", 0
format2  db "%d", 0
format3  db "modul = %d", 0xA, 0

section  .bss

a:       resb 4

section  .text

global   _main

_main:
;        esp -> [ret]

         push format

;        esp -> [format][ret]

         call _printf  ; printf(format);
         add esp, 4    ; esp = esp + 4

;        esp -> [ret]

         push a
         
;        esp -> [addr_a][ret]

         push format2

;        esp -> [format2][addr_a][ret]
         
         call _scanf   ; scanf("%d", &a);
         add esp, 2*4  ; esp = esp + 8

;        esp -> [ret]

         mov eax, dword [a]  ; eax = a
         mov edx, eax        ; edx = eax = a

         test eax, eax  ; eax AND eax = eax     ; OF SF ZF AF PF CF affected
         jns nieujemna  ; jump if sign not ser  ; SF = 0

         neg edx  ; edx = -edx
nieujemna:

         push edx

;        esp -> [edx][ret]

         push format3

;        esp -> [format3][edx][ret]

         call _printf  ; printf(format3, edx);
         add esp, 2*4    ; esp = esp + 8

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
