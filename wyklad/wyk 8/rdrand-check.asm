         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         mov ebp, ebx  ; ebp = ebx

         call getaddr
format1:
         db "the processor supports rdrand instruction", 0xA, 0
format2:
         db "the processor does not support rdrand instruction", 0xA, 0
getaddr:

;        esp -> [format1][ret]

         mov eax, 01h  ; eax = 1

         cpuid

         bt ecx, 30  ; bit test ; CF affected

         jc skip

         add dword [esp], format2-format1

;        esp -> [format2][ret]

skip:

         call [ebp+3*4]  ; printf(format_);
         add esp, 1*4    ; esp = esp + 4

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