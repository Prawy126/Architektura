         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         mov eax, 0  ; eax = 0
         
         clc      ; CF = 0       ; clear carry flag
         setc al  ; al = CF = 0  ; set byte if carry

         call print  ; fastcall

addr1:

;        esp -> [ret]

         stc      ; CF = 1       ; set carry flag
         setc al  ; al = CF = 1  ; set byte if carry

         call print  ; fastcall

addr2:

;        esp -> [ret]

         clc      ; CF = 0                   ; clear carry flag
         cmc      ; CF = CF ^ 1 = 0 ^ 1 = 1  ; complement carry flag
         setc al  ; al = CF = 1              ; set byte if carry

         call print  ; fastcall

addr3:

;        esp -> [ret]

         stc      ; CF = 1                   ; set carry flag
         cmc      ; CF = CF ^ 1 = 1 ^ 1 = 0  ; complement carry flag
         setc al  ; al = CF = 0              ; set byte if carry

         call print  ; fastcall

addr4:

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
         db "CF = %u", 0xA, 0
getaddr:

;        esp -> [format][eax][addr_][ret]

         call [ebx+3*4]  ; printf("CF = %u", eax);
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