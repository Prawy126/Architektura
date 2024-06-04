         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

a        equ 1
b        equ 1

         mov eax, a  ; eax = a
         mov ecx, b  ; ecx = b

         push ecx  ; ecx = b -> stack
         push eax  ; eax = a -> stack

;        esp -> [a][b][ret]

         call sum  ; cdecl

addr:

;        esp -> [a][b][ret]

         add esp, 2*4  ; esp = esp + 8

;        esp -> [ret]

         push edx  ; edx = sum_h -> stack
         push eax  ; eax = sum_l -> stack

;        esp -> [sum_l][sum_h][ret]

         call getaddr
format:
         db "sum = %llu", 0xA, 0
getaddr:

;        esp -> [format][sum_l][sum_h][ret]

         call [ebx+3*4]  ; printf(format, sum);
         add esp, 3*4    ; esp = esp + 12

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0);

;        int sum(int a, int b)

sum:

;                     +4 +8
;        esp -> [addr][a][b][ret]

         push ebp  ; ebp -> stack

;                          +8 +12
;        esp -> [ebp][addr][a][b][ret]

         mov ebp, esp  ; ebp = esp

;                          +8 +12
;        ebp -> [ebp][addr][a][b][ret]

         sub esp, 2*4  ; esp = esp - 8

;        ebp    -8     -4     +0         +8 +12
;        esp -> [sum_l][sum_h][ebp][addr][a][b][ret]

         mov eax, [ebp+8]   ; eax = *(int*)(ebp+8) = a
         add eax, [ebp+12]  ; eax = eax + *(int*)(ebp+12) = a + b ; CF affected

         mov [ebp-8], eax  ; *(int*)(ebp-8) = eax = a + b

         mov eax, 0  ; eax = 0
         adc eax, 0  ; eax = eax + CF = 0 + CF

         mov [ebp-4], eax  ; *(int*)(ebp-4) = CF

         mov eax, [ebp-8]  ; eax = *(int*)(ebp-8) = sum_l
         mov edx, [ebp-4]  ; edx = *(int*)(ebp-4) = sum_h

;        edx:eax = sum

         mov esp, ebp  ; esp = ebp

;        esp -> [ebp][addr][a][b][ret]

         pop ebp  ; ebp <- stack

;        esp -> [addr][a][b][ret]

         ret

; https://gynvael.coldwind.pl/?id=300
; https://gynvael.coldwind.pl/cli/

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
