         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

;        Negacja logiczna

         not eax  ; eax = ~eax

;        Suma logiczna

         or eax, edx  ; eax = eax | edx

;        Iloczyn logiczny

         and eax, edx  ; eax = eax & edx

;        Roznica symetryczna

         xor eax, edx  ; eax = eax ^ edx

;        Testowanie bitow

         test eax, edx  ; eax & edx

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