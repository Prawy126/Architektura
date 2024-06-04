         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         call rdrand32  ; fastcall

         call getaddr
format:
         db "this rand value is valid", 0xA, 0
format2:
         db "this rand value is invalid", 0xA, 0
getaddr:

;        esp -> [format][ret]

         jc valid

         add dword [esp], format2-format

;        esp -> [format2][ret]

valid:

         push eax  ; eax -> stack

;        esp -> [eax][format_][ret]

         call getaddr2
format3:
         db "rand = %u", 0xA, 0xA, 0
getaddr2:

;        esp -> [format3][eax][format_][ret]

         call [ebx+3*4]  ; printf(format3, eax);
         add esp, 2*4    ; esp = esp + 8

;        esp -> [format_][ret]

         call [ebx+3*4]  ; printf(format_);
         add esp, 1*4    ; esp = esp + 4

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0)

%define  RETRY_LIMIT 10

rdrand32 mov ecx, RETRY_LIMIT  ; ecx = RETRY_LIMIT

.loop:   rdrand eax  ; read random number

         jc done     ; jump if CF = 1

         loop .loop

done     ret

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
