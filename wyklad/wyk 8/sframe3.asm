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

         mov eax, [esp+4]  ; eax = *(int*)(esp+4) = a
         add eax, [esp+8]  ; eax = eax + *(int*)(esp+8) = a + b ; CF affected

         mov edx, 0  ; eax = 0
         adc edx, 0  ; eax = eax + CF = 0 + CF

;        edx:eax = sum

         ret

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
