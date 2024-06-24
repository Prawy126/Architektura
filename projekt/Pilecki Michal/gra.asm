         [bits 32]

;        esp -> [ret]

ROCK     equ 1
PAPER    equ 2
SCISSORS equ 3

check:
         mov ebp, ebx  ; ebp = ebx ; przeniesienie wskaznika asmloadera do ebp
         mov eax, 01h  ; eax = 1

         cpuid

         bt ecx, 30  ; test bitu ; CF jest zmieniane

         jc start  ; skok jezeli CF=1
         
         jmp rdrand_unsupported  ; powrot ze statusem niepowodzenia

start:
         mov ebx, ebp  ; ebx = ebp ; przywrocenie wskaznika asmloadera do API
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

         pop esi  ; esi <- stos = a ; wybor uzytkownika

;        esp -> [ret]

         cmp esi, 1  ; esi - 1
         jb invalid  ; skok jezeli ponizej
         cmp esi, 3  ; esi - 3
         ja invalid  ; skok jezeli powyzej

         call rdrand32  ; fastcall ; generowanie 32-bitowej liczby losowej do eax
                                   ; CF=1 jeśli liczba losowa zostala wygenerowana poprawnie, w przeciwnym razie CF=0

         jc valid       ; skok jezeli CF=1

         jmp rand_err   ; powrot ze statusem niepowodzenia

valid:
         xor edx, edx   ; edx = 0
         mov ecx, 3     ; ecx = 3              ; przedzial
         div ecx        ; eax = edx:eax / ecx  ; iloraz
                        ; edx = edx:eax % ecx  ; reszta
         mov eax, edx   ; eax = edx            ; liczba miedzy 0 a 2
         add eax, 1     ; eax = eax + 1        ; liczba miedzy 1 a 3

         cmp esi, eax       ; esi - eax
         je tie             ; skok jezeli rowne

         cmp esi, ROCK      ; esi - 1
         je _rock           ; skok jezeli rowne
         cmp esi, PAPER     ; esi - 2
         je _paper          ; skok jezeli rowne
         cmp esi, SCISSORS  ; esi - 3
         je _scissors       ; skok jezeli rowne

_rock:                      
         cmp eax, PAPER     ; eax - 2
         je w_pc_p          ; skok jezeli rowne ; pc wygrywa
         cmp eax, SCISSORS  ; eax - 3
         je l_pc_s          ; skok jezeli rowne ; pc przegrywa

_paper:
         cmp eax, ROCK      ; eax - 1
         je l_pc_r          ; skok jezeli rowne ; pc przegrywa
         cmp eax, SCISSORS  ; eax - 3
         je w_pc_s          ; skok jezeli rowne ; pc wygrywa

_scissors:
         cmp eax, ROCK      ; eax - 1
         je w_pc_r          ; skok jezeli rowne ; pc wygrywa
         cmp eax, PAPER     ; eax - 2
         je l_pc_p          ; skok jezeli rowne ; pc przegrywa

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

.loop:   rdrand eax  ; czytanie liczby losowej

         jc done     ; skok jezeli CF = 1

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
; FUNCTION_NR:
;
; 0 - exit
; 1 - putchar
; 2 - getchar
; 3 - printf
; 4 - scanf
;
; To co funkcja zwroci jest w EAX.
; Po wywolaniu funkcji sciagamy argumenty ze stosu..
;
; https://gynvael.coldwind.pl/?id=387
