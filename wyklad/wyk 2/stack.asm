         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         push 1    ; 1 -> stack

;        esp -> [01 00 00 00][ret]

         push eax  ; eax -> stack

;        esp -> [eax][01 00 00 00][ret]

         push ecx  ; ecx -> stack

;        esp -> [ecx][eax][01 00 00 00][ret]

         pop eax  ; eax <- stack

;        esp -> [eax][01 00 00 00][ret]

         pop ecx  ; ecx <- stack

;        esp -> [01 00 00 00][ret]

         mov edx, [esp]  ; edx = *(int*)esp = 1 ; peek

;        esp -> [01 00 00 00][ret]

         add esp, 4  ; esp = esp + 4

;        esp -> [ret]

         ret  ; return to asmloadder

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

%ifdef COMMENT

ebx    -> [ ][ ][ ][ ] -> exit
ebx+4  -> [ ][ ][ ][ ] -> putchar
ebx+8  -> [ ][ ][ ][ ] -> getchar
ebx+12 -> [ ][ ][ ][ ] -> printf
ebx+16 -> [ ][ ][ ][ ] -> scanf

%endif
