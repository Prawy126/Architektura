         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

a        equ 0xAAAA_AAAA

         mov eax, a  ; eax = a

         call print  ; fastcall

addr1:

;        esp -> [ret]

         mov ah, 0x77  ; ah = 0x77 ; liczba dodatnia w kodzie U2

         call print    ; fastcall

addr2:

;        esp -> [ret]

         movsx eax, ah  ; eax = ah >= 0 ? 0:ah : -1:ah  ; move and sign extend

         call print     ; fastcall

addr3:

;        esp -> [ret]

         mov ah, 0x88  ; ah = 0x88 ; liczba ujemna w kodzie U2

         call print    ; fastcall

addr4:

;        esp -> [ret]

         movsx eax, ah  ; eax = ah >= 0 ? 0:ah : -1:ah

         call print  ; fastcall

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0);

print:

;        esp -> [addr_][ret]

         mov esi, eax  ; esi = eax ; store eax

         push eax

;        esp -> [eax][addr_][ret]

         call getaddr
format:
         db "eax = %08X", 0xA, 0
getaddr:

;        esp -> [format][eax][addr_][ret]

         call [ebx+3*4]  ; printf("eax = %8X", eax);
         adc esp, 2*4    ; esp = esp + 8

;        esp -> [addr_][ret]

         mov eax, esi  ; eax = esi ; restore eax

         ret

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