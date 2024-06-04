%ifdef COMMENT
0   1   2   3   4   5   6    indeksy
1   1   2   3   5   8   13   wartosci

f(0) = 1
f(1) = 1
f(n) = f(n-1) + f(n-2)

Pierwszy i drugi wyraz ci¹gu Fibonacciego
przyjmuje wartoœæ 1, a ka¿dy kolejny wyraz
jest sum¹ dwóch poprzednich.
%endif

         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

n        equ 6

         mov ecx, n  ; ecx = n

         call fibo   ; eax = fibo(ecx) ; fastcall

raddr:

;        esp -> [ret]

         push eax

;        esp -> [eax][ret]

         call getaddr
format:
         db "fibo = %i", 0xA, 0
getaddr:

;        esp -> [format][eax][ret]

         call [ebx+3*4]  ; printf("fibo = %i\n", eax);
         add esp, 2*4    ; esp = esp + 8

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0);

;        eax fibo(ecx)

fibo     cmp ecx, 0    ; ecx - 0           ; ZF affected
         jne next      ; jump if not equal ; jump if ZF = 0
         mov eax, 1    ; eax = 1
         ret

next     cmp ecx, 1    ; ecx - 1           ; ZF affected
         jne rec       ; jump if not equal ; jump if ZF = 0
         mov eax, ecx  ; eax = ecx = 1
         ret

rec      dec ecx       ; ecx = ecx - 1 = n - 1
         push ecx      ; ecx -> stack = n - 1
         call fibo     ; eax = fibo(ecx) = fibo(n - 1)
         pop ecx       ; ecx <- stack = n - 1
         dec ecx       ; ecx = ecx - 1 = n - 2
         push eax      ; eax -> stack = fibo(n - 1)
         call fibo     ; eax = fibo(ecx) = fibo(n - 2)
         pop ecx       ; ecx <- stack = fibo(n - 1)
         add eax, ecx  ; eax = eax + ecx = fibo(n - 2) + fibo(n - 1)
         ret

; silnia(0) = 1
; silnia(n) = n * silnia(n-1)

%ifdef COMMENT
eax = silnia(ecx)

* silnia(5) =           * silnia(5) = 120
  ecx -> stack = 5      ecx -> stack = 5
  ecx = ecx - 1 = 4     ecx = ecx - 1 = 4
  eax = silnia(4) =     eax = silnia(4) = 24
  ecx <- stack = 5      ecx <- stack = 5
  eax = eax * ecx =     eax = eax * ecx = 24 * 5 = 120
  return eax =          return eax = 120

* silnia(4) =           * silnia(4) = 24
  ecx -> stack = 4      ecx -> stack = 4
  ecx = ecx - 1 = 3     ecx = ecx - 1 = 3
  eax = silnia(3) =     eax = silnia(3) = 6
  ecx <- stack = 4      ecx <- stack = 4
  eax = eax * ecx =     eax = eax * ecx = 6 * 4 = 24
  return eax =          return eax = 2
  
* silnia(3) =           * silnia(3) = 6
  ecx -> stack = 3      ecx -> stack = 3
  ecx = ecx - 1 = 2     ecx = ecx - 1 = 2
  eax = silnia(2) =     eax = silnia(2) = 2
  ecx <- stack = 3      ecx <- stack = 3
  eax = eax * ecx =     eax = eax * ecx = 2 * 3 = 6
  return eax =          return eax = 6
  
* silnia(2) =           * silnia(2) = 2
  ecx -> stack = 2      ecx -> stack = 2
  ecx = ecx - 1 = 1     ecx = ecx - 1 = 1
  eax = silnia(1) =     eax = silnia(1) = 1
  ecx <- stack = 2      ecx <- stack = 2
  eax = eax * ecx =     eax = eax * ecx = 1 * 2 = 2
  return eax =          return eax = 2
  
* silnia(1) =           * silnia(1) = 1
  ecx -> stack = 1      ecx -> stack = 1
  ecx = ecx - 1 = 0     ecx = ecx - 1 = 0
  eax = silnia(0) =     eax = silnia(0) = 1
  ecx <- stack = 1      ecx <- stack = 1
  eax = eax * ecx =     eax = eax * ecx = 1 * 1 = 1
  return eax =          return eax = 1

* silnia(0) =
  eax = 1
  return eax = 1
%endif

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
