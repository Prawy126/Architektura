         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

start:
         call $+5  ; *(int*)(esp-4) = $ + 5 = start + 5 = addr ; eip = addr ; $ denotes the current address

addr:              ; return address 

;        esp -> [addr][ret]  ; addr = start + 5 as call instruction takes 5 bytes

         sub dword [esp], 5  ; *(int*)esp = *(int*)esp - 5 = start

;        esp -> [start][ret]

         call getaddr
format:
         db "start = %p", 0xA, 0
getaddr:

;        esp -> [format][start][ret]

         call [ebx+3*4]  ; printf("start = %p\n", start);
         add esp, 2*4    ; esp = esp + 8
         
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