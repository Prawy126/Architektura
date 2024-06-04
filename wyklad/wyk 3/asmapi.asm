%ifdef COMMENT
ebx    -> [ ][ ][ ][ ] -> exit
ebx+4  -> [ ][ ][ ][ ] -> putchar
ebx+8  -> [ ][ ][ ][ ] -> getchar
ebx+12 -> [ ][ ][ ][ ] -> printf
ebx+16 -> [ ][ ][ ][ ] -> scanf
%endif

         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         push dword [ebx+16]  ; *(int*)(esp-4) = *(int*)(ebx+16) = scanf   ; esp = esp - 4
         push dword [ebx+12]  ; *(int*)(esp-4) = *(int*)(ebx+12) = printf  ; esp = esp - 4
         push dword [ebx+8]   ; *(int*)(esp-4) = *(int*)(ebx+8)  = getchar ; esp = esp - 4
         push dword [ebx+4]   ; *(int*)(esp-4) = *(int*)(ebx+4)  = putchar ; esp = esp - 4
         push dword [ebx]     ; *(int*)(esp-4) = *(int*)ebx      = exit    ; esp = esp - 4

;        esp -> [exit][putchar][getchar][printf][scanf][ret]

         call getaddr
format:
         db "exit    = %p", 0xA
         db "putchar = %p", 0xA
         db "getchar = %p", 0xA
         db "printf  = %p", 0xA
         db "scanf   = %p", 0xA, 0
getaddr:

;        esp -> [format][exit][putchar][getchar][printf][scanf][ret]

         call [ebx+3*4]  ; printf(format, exit, putchar, getchar, printf, scanf);
         add esp, 6*4    ; esp = esp + 24

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

