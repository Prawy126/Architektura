         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

a        equ 5

         mov eax, a    ; eax = a
         mov ecx, eax  ; ecx = eax = a

         neg ecx  ; ecx = -ecx = -a

         push ecx  ; -a -> stack
         push eax  ;  a -> stack

;        esp -> [a][-a][ret]

         call getaddr
format:
         db " a = %d", 0xA
         db "-a = %d", 0xA, 0
getaddr:

;        esp -> [format][a][-a][ret]

         call [ebx+3*4]  ; printf(format, a, -a);
         add esp, 3*4    ; esp = esp + 12

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

