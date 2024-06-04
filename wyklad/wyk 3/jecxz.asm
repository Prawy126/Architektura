         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

n        equ 5

         mov ecx, n  ; ecx = n

         call getaddr

format1  db "ecx == 0", 0xA, 0
format2  db "ecx != 0", 0xA, 0

getaddr:

;        esp -> [format1][ret]

         jecxz skip  ; jump if ecx is zero ; jump if ecx = 0

         add dword [esp], format2 - format1 ; *(int*)esp = *(int*)esp + format2 - format1 = format2

;        esp -> [format2][ret]

skip     call [ebx+3*4]  ; printf(format);
         adc esp, 1*4    ; esp = esp + 4

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
; To co funkcja zwr�ci jest w EAX.
; Po wywolaniu funkcji sciagamy argumenty ze stosu.
;
; https://gynvael.coldwind.pl/?id=387