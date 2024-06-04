         [bits 64]

%ifdef COMMENT
rcx, rdx, r8, r9, stack for integer, struct or pointer arguments

xmm0, xmm1, xmm2, xmm3, stack for floating point arguments

rax for integer return values

xmm0 for floating point return values

registers rax, rcx, rdx, r8, r9, r10, r11 are volatile (caller-saved)

registers rbx, rbp, rdi, rsi, rsp, r12, r13, r14, r15 are nonvolatile (callee-saved)
%endif

extern   printf

global   main

section  .text

a        equ 1
b        equ 2
c        equ 3
d        equ 4
e        equ 5

main:

;        rsp -> [ret]

;        rcx, rdx, r8, r9, stack

         mov rcx, format  ; rcx = format
         mov rdx, a       ; rdx = a
         mov r8, b        ; r8 = b
         mov r9, c        ; r9 = c

         push e
         push d

;        rsp -> [d][e][ret]

         sub  rsp, 32  ; reserve the shadow space

;        rsp -> [shadow][d][e][ret]

         call printf  ; printf(format, a, b, c, d, e);

         add  rsp, 32 + 2*8  ; rsp = rsp + 48

;        rsp -> [ret]

         ret

format:
         db "a = %d", 0xA
         db "b = %d", 0xA
         db "c = %d", 0xA
         db "d = %d", 0xA
         db "e = %d", 0xA, 0

%ifdef COMMENT
Kompilacja:

nasm ms64call.asm -o ms64call.obj -f win64

golink /console /entry main ms64call.obj msvcrt.dll

lub

nasm ms64call.asm -o ms64call.o -f win64

gcc ms64call.o -o ms64call.exe -m64
%endif
