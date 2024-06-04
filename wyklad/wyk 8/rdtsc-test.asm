         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         rdtsc  ; read time-stamp counter

         mov esi, eax  ; esi = eax
         mov edi, edx  ; edi = edx

;        start of test code

         cmp eax, ebx
         cmp eax, ebx
         cmp eax, ebx
         cmp eax, ebx
         cmp eax, ebx
         cmp eax, ebx
         cmp eax, ebx
         cmp eax, ebx
         cmp eax, ebx
         cmp eax, ebx

;        end of test code

         rdtsc

         sub eax, esi  ; eax = eax - esi       ; CF affected
         sbb edx, edi  ; edx = edx - edi - CF  ; CF affected

         push edx
         push eax

;        esp -> [eax][edx][ret]

         call getaddr
format:
         db "cycles = %llu", 0xA, 0
getaddr:

;        esp -> [format][eax][edx][ret]

         call [ebx+3*4]  ; printf("cycles = llu\n", edx:eax);
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