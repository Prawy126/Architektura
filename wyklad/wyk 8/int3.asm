         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

a        equ 145

         call getaddr
addr_a:
         dd a  ; [ ][ ][ ][ ]   define double word
getaddr:

;        esp -> [addr_a][ret]

         mov ebp, [esp]    ; ebp = *(int*)esp = addr_a

         push dword [ebp]  ; *(int*)ebp = *(int*)addr_a = a -> stack

;        esp -> [a][addr_a][ret]

         call getaddr2
format:
         db "int value = %d", 0xA, 0
getaddr2:

;        esp -> [format][a][addr_a][ret]

         call [ebx+3*4]  ; printf(format, a);
         add esp, 3*4    ; esp = esp + 12

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0)

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
; To co funkcja zwr�ci jest w EAX.
; Po wywolaniu funkcji sciagamy argumenty ze stosu.
;
; https://gynvael.coldwind.pl/?id=387
