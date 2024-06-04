         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

a        equ 0y0000_1111
b        equ 0y1111_0000

         mov al, a  ; al = a
         mov cl, b  ; cl = b

         or al, cl  ; al = al | cl

         mov ecx, 8  ; ecx = 8
         mov edx, 0  ; edx = 0

petla    shl edx, 4  ; edx = edx << 4 = edx*16
         shl al, 1   ; CF = al >> 7 ; al = al << 1
         adc edx, 0  ; edx = edx + 0 + CF

         loop petla

         push edx

;        esp -> [edx][ret]

         call getaddr
format:
         db "or = %08x", 0xA, 0
getaddr:

;        esp -> [format][edx][ret]

         call [ebx+3*4] ; printf("or = %08x\n", edx);
         add esp, 2*4   ; esp = esp + 8

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