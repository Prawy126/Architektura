         [bits 32]

;        esp -> [ret]

ROCK     equ 1
PAPER    equ 2
SCISSORS equ 3

check:
         mov ebp, ebx  ; ebp = ebx ; move asmloader pointer to ebp, cpuid affects ebx
         mov eax, 01h  ; eax = 1

         cpuid

         bt ecx, 30  ; bit test ; CF affected

         jc start  ; jump if CF=1
         
         jmp rdrand_unsupported  ; return with failure status

start:
         mov ebx, ebp  ; ebx = ebp ; restore asmloader pointer to API
         call getaddr1

format1:
         db "1. Kamien", 0xA
         db "2. Papier", 0xA
         db "3. Scyzoryk", 0xA
         db "Wybierz przedmiot: ", 0
getaddr1:

;        esp -> [format1][ret]

         call [ebx+3*4]  ; printf(format1);

         push esp

;        esp -> [addr_a][a][ret]

         call getaddr2
format2:
         db "%u", 0
getaddr2:

;        esp -> [format2][addr_a][a][ret]

         call [ebx+4*4]  ; scanf(format2, &a);
         add esp, 2*4    ; esp = esp + 8

;        esp -> [a][ret]

         pop esi  ; esi <- stack = a ; wybor uzytkownika

;        esp -> [ret]

         cmp esi, 1  ; esi - 1
         jb invalid  ; jump if below
         cmp esi, 3  ; esi - 3
         ja invalid  ; jump if above

         call rdrand32  ; fastcall ; generate a 32 bit random number into eax
                                   ; CF=1 if random number generated ok, otherwise CF=0

         jc valid       ; jump if CF=1

         jmp rand_err   ; return with failure status

valid:
         xor edx, edx   ; edx = 0
         mov ecx, 3     ; ecx = 3              ; przedzia³
         div ecx        ; eax = edx:eax / ecx  ; iloraz
                        ; edx = edx:eax % ecx  ; reszta
         mov eax, edx   ; eax = edx            ; liczba miedzy 0 a 2
         add eax, 1     ; eax = eax + 1        ; liczba miedzy 1 a 3

         cmp esi, eax       ; esi - eax
         je tie             ; jump if equals

         cmp esi, ROCK      ; esi - 1
         je _rock           ; jump if equals
         cmp esi, PAPER     ; esi - 2
         je _paper          ; jump if equals
         cmp esi, SCISSORS  ; esi - 3
         je _scissors       ; jump if equals

_rock:
         cmp eax, PAPER     ; eax - 2
         je w_pc_p          ; jump if equals ; pc win
         cmp eax, SCISSORS  ; eax - 3
         je l_pc_s          ; jump if equals ; pc lost

_paper:
         cmp eax, ROCK      ; eax - 1
         je l_pc_r          ; jump if equals ; pc lost
         cmp eax, SCISSORS  ; eax - 3
         je w_pc_s          ; jump if equals ; pc win

_scissors:
         cmp eax, ROCK      ; eax - 1
         je w_pc_r          ; jump if equals ; pc win
         cmp eax, PAPER     ; eax - 2
         je l_pc_p          ; jump if equals ; pc lost

tie:
         call getaddr3
format3:
         db 0xA, "Remis, komputer wylosowal to samo.", 0xA, 0
getaddr3:
         call [ebx+3*4]  ; printf(format3);
         jmp end

w_pc_r:
         call getaddr4
format4:
         db 0xA, "Komputer wylosowal kamien i wygral.", 0xA, 0
getaddr4:
         call [ebx+3*4]  ; printf(format4);
         jmp end

w_pc_p:
         call getaddr5
format5:
         db 0xA, "Komputer wylosowal papier i wygral.", 0xA, 0
getaddr5:
         call [ebx+3*4]  ; printf(format5);
         jmp end

w_pc_s:
         call getaddr6
format6:
         db 0xA, "Komputer wylosowal scyzoryk i wygral.", 0xA, 0
getaddr6:
         call [ebx+3*4]  ; printf(format6);
         jmp end
         
l_pc_r:
         call getaddr7
format7:
         db 0xA, "Komputer wylosowal kamien i przegral.", 0xA, 0
getaddr7:
         call [ebx+3*4]  ; printf(format7);
         jmp end

l_pc_p:
         call getaddr8
format8:
         db 0xA, "Komputer wylosowal papier i przegral.", 0xA, 0
getaddr8:
         call [ebx+3*4]  ; printf(format8);
         jmp end

l_pc_s:
         call getaddr9
format9:
         db 0xA, "Komputer wylosowal scyzoryk i przegral.", 0xA, 0
getaddr9:
         call [ebx+3*4]  ; printf(format9);
         jmp end

invalid:
         call getaddr10
format10:
         db 0xA, "Wybierz kamien, papier lub scyzoryk.", 0xA, 0
getaddr10:
         call [ebx+3*4]  ; printf(format10);
         jmp end
         
rand_err:
         call getaddr11
format11:
         db 0xA, "Zostala wylosowana niepoprawna liczba losowa.", 0xA, 0
getaddr11:
         call [ebx+3*4]  ; printf(format11);
         jmp end

rdrand_unsupported:
         call getaddr12
format12:
         db 0xA, "Procesor nie wspiera instrukcji rdrand.", 0xA, 0
getaddr12:
         call [ebp+3*4]  ; printf(format12);
         jmp end

end:
         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0);   


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