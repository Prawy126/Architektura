         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         push edi
         push esi
         push ebp
         push esp
         push ebx
         push edx
         push ecx
         push eax

;        esp -> [eax][ecx][edx][ebx][esp][ebp][esi][edi][ret]

         call getaddr
format:
         db "eax = %08X", 0xA
         db "ecx = %08X", 0xA
         db "edx = %08X", 0xA
         db "ebx = %08X", 0xA
         db "esp = %08X", 0xA
         db "ebp = %08X", 0xA
         db "esi = %08X", 0xA
         db "edi = %08X", 0xA, 0
getaddr:

;        esp -> [format][eax][ecx][edx][ebx][esp][ebp][esi][edi][ret]

         call [ebx+3*4] ; printf(format, eax, ecx, edx, ebx, esp, ebp, esi, edi);
         add esp, 9*4   ; esp = esp + 36

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