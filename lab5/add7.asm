         [bits 64]

a        equ 4294967295
b        equ 1

section .data
format:
         db 'suma = %llu', 0xA, 0

section .text
global _start

_start:

         mov eax, a      ; RAX = a
         xor rdx, rdx    ; Zero-extend RAX to 64 bits (RDX:RAX = a)
         mov ecx, b      ; RCX = b
         xor rbx, rbx    ; Zero-extend RCX to 64 bits (RBX:RCX = b)

         add rax, rcx    ; RAX = RAX + RCX
         adc rdx, rbx    ; RDX = RDX + RBX + CF

         lea rdi, [format]   ; Load address of the format string
         mov rsi, rax        ; Load the lower 4 bytes of the result
         mov rdx, rdx        ; Load the higher 4 bytes of the result

         ; Write the result to stdout
         mov rax, 1       ; System call number for write (1)
         mov rdi, 1       ; File descriptor for stdout (1)
         mov rdx, 21      ; Length of the output string
         syscall

         ; Exit
         mov rax, 60      ; System call number for exit (60)
         xor rdi, rdi     ; Exit status (0)
         syscall

; asmloader API
;
; ESP wskazuje na prawidlowy stos
; argumenty funkcji wrzucamy na stos
; EBX zawiera pointer na tablice API
;
; call [ebx + NR_FUNKCJI*4] ; wywolanie funkcji API
;
; NR_FUNKCJI:
;
; 0 - exit
; 1 - putchar
; 2 - getchar
; 3 - printf
; 4 - scanf
;
; To co funkcja zwróci jest w EAX.
; Po wywolaniu funkcji sciagamy argumenty ze stosu.
;
; https://gynvael.coldwind.pl/?id=387

%ifdef COMMENT

Tablica API

rbx    -> [ ][ ][ ][ ] -> exit
rbx+8  -> [ ][ ][ ][ ] -> putchar
rbx+16  -> [ ][ ][ ][ ] -> getchar
rbx+24 -> [ ][ ][ ][ ] -> printf
rbx+32 -> [ ][ ][ ][ ] -> scanf

%endif
