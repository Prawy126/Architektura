         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         pushad  ; esp = esp - 8*4        ; push general-purpose registers onto stack
                 ; *(int*)esp      =  edi
                 ; *(int*)(esp+4)  =  esi
                 ; *(int*)(esp+8)  =  ebp
                 ; *(int*)(esp+12) =  esp
                 ; *(int*)(esp+16) =  ebx
                 ; *(int*)(esp+20) =  edx
                 ; *(int*)(esp+24) =  ecx
                 ; *(int*)(esp+28) =  eax

;        esp -> [edi][esi][ebp][esp][ebx][edx][ecx][eax][ret]

         popad  ; edi = *(int*)esp       ; pop general-purpose registers from stack
                ; esi = *(int*)(esp+4)
                ; ebp = *(int*)(esp+8)
                ; esp = *(int*)(esp+12)
                ; ebx = *(int*)(esp+16)
                ; edx = *(int*)(esp+20)
                ; ecx = *(int*)(esp+24)
                ; eax = *(int*)(esp+28) ; esp = esp + 8*4

;        esp -> [ret]

         pushad

;        esp -> [edi][esi][ebp][esp][ebx][edx][ecx][eax][ret]

         call getaddr
format:
         db "edi = %08X", 0xA
         db "esi = %08X", 0xA
         db "ebp = %08X", 0xA
         db "esp = %08X", 0xA
         db "ebx = %08X", 0xA
         db "edx = %08X", 0xA
         db "ecx = %08X", 0xA
         db "eax = %08X", 0xA, 0
getaddr:

;        esp -> [format][edi][esi][ebp][esp][ebx][edx][ecx][eax][ret]

         call [ebx+3*4] ; printf(format, edi, esi, ebp, esp, ebx, edx, ecx, eax);
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