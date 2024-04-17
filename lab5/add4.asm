        [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

%define  UINT_MAX 4294967295

a        equ 4294967295
b        equ 1

         mov eax, a  ; eax = a
         mov ecx, b  ; ecx = b

         sub esp, 2*4  ; esp = esp - 4

;        esp -> [s_l][s_h][ret]

         push ecx  ; ecx = b -> stack
         push eax  ; eax = a -> stack

;                     +8   +12
;        esp -> [a][b][s_l][s_h][ret]

         clc                ; CF = 0
         adc eax, ecx       ; eax = eax + ecx + CF

         mov [esp+8], eax   ; *(int*)(esp+8) = eax

         mov edx, 0         ; edx = 0
         adc edx, 0         ; edx = edx + CF

         mov [esp+12], edx  ; *(int*)(esp+4) = edx

         call getaddr
format:
         db "a = %u", 0xA
         db "b = %u", 0xA, 0xA
         db "suma = %llu", 0xA, 0
getaddr:

;        esp -> [format][a][b][s_l][s_h][ret]

         call [ebx+3*4]  ; printf(format, a, b, s);
         add esp, 5*4    ; esp = esp + 20

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0);

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