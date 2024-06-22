         [bits 32]

ROCK     equ 1
PAPER    equ 2
SCISSORS equ 3

extern   _printf
extern   _scanf
extern   _exit

section  .data

format1:
         db "1. Kamien", 0xA
         db "2. Papier", 0xA
         db "3. Scyzoryk", 0xA
         db "Wybierz przedmiot: ", 0
format2:
         db "%u", 0
format3:
         db 0xA, "Remis, komputer wylosowal to samo.", 0xA, 0
format4:
         db 0xA, "Komputer wylosowal kamien i wygral.", 0xA, 0
format5:
         db 0xA, "Komputer wylosowal papier i wygral.", 0xA, 0
format6:
         db 0xA, "Komputer wylosowal scyzoryk i wygral.", 0xA, 0
format7:
         db 0xA, "Komputer wylosowal kamien i przegral.", 0xA, 0
format8:
         db 0xA, "Komputer wylosowal papier i przegral.", 0xA, 0
format9:
         db 0xA, "Komputer wylosowal scyzoryk i przegral.", 0xA, 0
format10:
         db 0xA, "Wybierz kamien, papier lub scyzoryk.", 0xA, 0
format11:
         db 0xA, "Zostala wylosowana niepoprawna liczba losowa.", 0xA, 0
format12:
         db 0xA, "Procesor nie wspiera instrukcji rdrand.", 0xA, 0

section  .bss

a:       resb 4

section  .text

global   _main

_main:

check:
         mov eax, 01h  ; eax = 1

         cpuid

         bt ecx, 30  ; bit test ; CF affected

         jc start  ; jump if CF=1
         
         jmp rdrand_unsupported  ; return with failure status

start:
         push format1

;        esp -> [format1][ret]

         call _printf  ; printf(format1);

         add esp, 4

;        esp -> [ret]

         push a
         push format2

;        esp -> [format2][addr_a][ret]

         call _scanf   ; scanf(format2, &a);
         add esp, 2*4  ; esp = esp + 8

;        esp -> [ret]

         mov esi, dword [a]  ; esi <- stack = a ; wybor uzytkownika

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
         mov ecx, 3     ; ecx = 3              ; przedzial
         div ecx        ; eax = edx:eax / ecx  ; iloraz
                        ; edx = edx:eax % ecx  ; reszta
         mov eax, edx   ; eax = edx            ; liczba mi?dzy 0 a 2
         add eax, 1     ; eax = eax + 1        ; liczba mi?dzy 1 a 3

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
         push format3
         call _printf  ; printf(format3);
         jmp end

w_pc_r:
         push format4
         call _printf  ; printf(format4);
         jmp end

w_pc_p:
         push format5
         call _printf  ; printf(format5);
         jmp end

w_pc_s:
         push format6
         call _printf  ; printf(format6);
         jmp end

l_pc_r:
         push format7
         call _printf  ; printf(format7);
         jmp end

l_pc_p:
         push format8
         call _printf  ; printf(format8);
         jmp end

l_pc_s:
         push format9
         call _printf  ; printf(format9);
         jmp end

invalid:
         push format10
         call _printf  ; printf(format10);
         jmp end

rand_err:
         push format11
         call _printf  ; printf(format11);
         jmp end

rdrand_unsupported:
         push format12
         call _printf  ; printf(format12);
         jmp end

end:
         push 0      ; esp -> [0][ret]
         call _exit  ; exit(0);


%define  RETRY_LIMIT 10

rdrand32 mov ecx, RETRY_LIMIT  ; ecx = RETRY_LIMIT

.loop:   rdrand eax  ; read random number

         jc done     ; jump if CF = 1

         loop .loop

done     ret


%ifdef COMMENT

Kompilacja:

nasm gra1.asm -o gra1.o -f win32
ld gra1.o -o gra1.exe c:\windows\system32\msvcrt.dll -m i386pe

lub:

nasm gra1.asm -o gra1.o -f win32
gcc gra1.o -o gra1.exe -m32

%endif
