%ifdef COMMENT
* fastcall

- argumenty funkcji przekazywane przez rejestry ecx, edx lub eax, ecx, edx
- ewaluacja argumentów od lewej do prawej
- wartosc funkcji zwracana w rejestrze eax lub eax, edx

https://en.wikipedia.org/wiki/Calling_convention
%endif

         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

a        equ 5
b        equ 10

         mov ecx, a  ; ecx = a ; argumenty do funkcji fun przekazywane przez rejestry
         mov edx, b  ; edx = b ;

         call fun    ; fastcall

addr:                ; return address

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0);

fun:

;        esp -> [addr][ret]

         push edx  ; cdecl
         push ecx  ; argumenty do funkcji printf przekazywane przez stos od prawej do lewej

;        esp -> [ecx][edx][addr][ret]

         call getaddr
format:
         db "a = %i", 0xA
         db "b = %i", 0xA, 0
getaddr:

;        esp -> [format][eax][edx][addr][ret]

         call [ebx+3*4]  ; printf("a = %i\nb = %i\n", eax, edx);
         add esp, 3*4    ; esp = esp + 12

;        esp -> [addr][ret]

         ret  ; eip = *(int*)esp = addr ; esp = esp + 4

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
