         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         mov ax, 200          ; decimal
         mov ax, 0200         ; still decimal
         mov ax, 0200d        ; explicitly decimal
         mov ax, 0d200        ; also decimal

         mov ax, 0c8h         ; hex
         mov ax, $0c8         ; hex again: the 0 is required
         mov ax, 0xc8         ; hex yet again
         mov ax, 0hc8         ; still hex

         mov ax, 310q         ; octal
         mov ax, 310o         ; octal again
         mov ax, 0o310        ; octal yet again
         mov ax, 0q310        ; octal yet again

         mov ax, 11001000b    ; binary
         mov ax, 1100_1000b   ; same binary constant
         mov ax, 1100_1000y   ; same binary constant once more
         mov ax, 0b1100_1000  ; same binary constant yet again
         mov ax, 0y1100_1000  ; same binary constant yet again

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
; https://gynvael.coldwind.pl/?id=38
  
