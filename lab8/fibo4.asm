[bits 32]


%ifdef COMMENT

0   1   2   3   4   5   6    indeksy

a   b
|---|
1   1   2   3   5   8   13   wartosci
|   |---|
d   a   b

Przesuniecie ramki:

d = a              ; d = 1
a = b              ; a = 1
b = a + d = b + d  ; b = 1 + 1 = 2

%endif

n        equ 5

         mov ebp, ebx  ; ebp = ebx

         mov ecx, n  ; ecx = n

         mov eax, 1  ; eax = 1
         mov ebx, 1  ; ebx = 1

         mov esi, ecx  ; esi = ecx
         sub esi, 2    ; esi = esi - 2

         test esi, esi ; SF, ZF, PF affected
         jns next1     ; jump not signed

         jmp done

next1    sub ecx, 1  ; ecx = ecx - 1

shift    mov edx, eax  ; edx = eax
         mov eax, ebx  ; ebx = edx
         add ebx, edx  ; edx = edx + ebx

         loop shift

done     push ebx

;        esp -> [ebx][ret]

         call getaddr  ; push on the stack the run-time address of format and jump to getaddr
format:
         db "fibo = %i", 0xA, 0
getaddr:

;        esp -> [format][ebx][ret]

         call [ebp+3*4]  ; pritnf(format, ebx)
         add esp, 2*4    ; esp = esp + 8

;        esp -> [format]

         push 0          ; esp -> [00 00 00 00][ret]
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
 
%ifdef COMMENT
 
ebx    -> [ ][ ][ ][ ] -> exit
ebx+4  -> [ ][ ][ ][ ] -> putchar
ebx+8  -> [ ][ ][ ][ ] -> getchar
ebx+12 -> [ ][ ][ ][ ] -> printf
ebx+16 -> [ ][ ][ ][ ] -> scanf
 
%endif
