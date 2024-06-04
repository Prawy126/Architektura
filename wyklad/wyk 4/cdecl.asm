%ifdef COMMENT
* cdecl

- argumenty funkcji przekazywane przez stos od prawej do lewej
- caller zapamietuje rejestry eax, ecx, edx a pozostale callee
- caller sciaga argumenty ze stosu
- wartosc funkcji zwracana w rejestrze eax lub edx:eax

https://en.wikipedia.org/wiki/Calling_convention
%endif

         [bits 32]

;        esp -> [ret] ; ret - adres powrotu do asmloader

a        equ 5
b        equ 10

         mov eax, a  ; eax = a
         mov ecx, b  ; ecx = b

         push ecx  ; cdecl
         push eax  ; argumenty funkcji przekazywane przez stos od prawej do lewej

;        esp -> [eax][ecx][ret]

         call fun  ; cdecl

addr:

;        esp -> [eax][ecx][ret]

         add esp, 2*4  ; esp = esp + 8 ; caller sciaga argumenty ze stosu

;        esp -> [ret]

         push 0         ; esp -> [0][ret]
         call [ebx+0*4] ; exit(0);

fun:

;                     +4   +8
;        esp -> [addr][eax][ecx][ret]

         push dword [esp+8]  ; *(int*)(esp-4) = *(int*)(esp+8) ; esp = esp - 4

;                    +4    +8
;        esp -> [ecx][addr][eax][ecx][ret]

         push dword [esp+8]  ; *(int*)(esp-4) = *(int*)(esp+8) ; esp = esp - 4

;        esp -> [eax][ecx][addr][eax][ecx][ret]

         call getaddr
format:
         db "a = %i", 0xA
         db "b = %i", 0xA, 0
getaddr:

;        esp -> [format][eax][ecx][addr][eax][ecx][ret]

         call [ebx+3*4]  ; printf("a = %i\nb = %i\n", eax, ecx);
         add esp, 3*4    ; esp = esp + 12

;        esp -> [addr][eax][ecx][ret]

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