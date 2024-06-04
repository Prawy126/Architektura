         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         mov ebp, ebx  ; ebp = ebx

         push 0xA  ; 0xA -> stack

;        esp -> [0A 00 00 00][ret]

         mov eax, 0  ; eax = 0

         cpuid

         push ecx
         push edx
         push ebx

;        esp -> [ebx][edx][ecx][0A 00 00 00][ret]

         push esp

;                      +4
;        esp -> [esp+4][ebx][edx][ecx][0A 00 00 00][ret]

         call [ebp+3*4]  ; printf(...);
         add esp, 4*4    ; esp = esp + 16

;        esp -> [0A 00 00 00][ret]

         mov eax, 0x80000004  ; eax = 0x80000004

         cpuid

         push edx
         push ecx
         push ebx
         push eax

;        esp -> [eax][ebx][ecx][edx][0A 00 00 00][ret]

         mov eax, 0x80000003 ; eax = 0x80000003

         cpuid

         push edx
         push ecx
         push ebx
         push eax

;        esp -> [eax][ebx][ecx][edx][eax][ebx][ecx][edx][0A 00 00 00][ret]

         mov eax, 0x80000002 ; eax = 0x80000002

         cpuid

         push edx
         push ecx
         push ebx
         push eax

;        esp -> [eax][ebx][ecx][edx][eax][ebx][ecx][edx][eax][ebx][ecx][edx][0A 00 00 00][ret]

         push esp

;                      +4
;        esp -> [esp+4][eax][ebx][ecx][edx][eax][ebx][ecx][edx][eax][ebx][ecx][edx][0A 00 00 00][ret]

         call [ebp+3*4]  ; printf();
         add esp, 14*4   ; esp = esp + 116

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebp+0*4]  ; exit(0);

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