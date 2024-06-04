         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         mov eax, 0x11223344  ; eax = 0x11223344

         push eax

;        esp -> [11223344][ret]

         bswap eax  ; eax = 0x44332211

         push eax

;        esp -> [44332211][11223344][ret]

         call getaddr
format:
         db "eax = %x", 0xA
         db "eax = %x", 0xA, 0
getaddr:

;        esp -> [format][44332211][11223344][ret]

         call [ebx+3*4]  ; printf(format, 0x44332211, 0x11223344);
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