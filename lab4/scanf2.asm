assembly
Copy code
[bits 32]

section .data
format db "Enter a number: ", 0
input_format db "%d", 0    ; Format dla scanf do czytania liczby ca�kowitej
number dd 0                ; Miejsce na zmienn� gdzie scanf zapisze warto��

section .text
global _start

_start:
    ; Wydrukuj monit
    push format
    call [printf]
    add esp, 4

    ; Przygotowanie argument�w dla scanf - adres zmiennej number
    push number
    push input_format
    call [scanf]
    ; Czyszczenie stosu po argumentach (2 argumenty po 4 bajty ka�dy)
    add esp, 8

    ; Wydrukuj wprowadzon� warto��
    push number
    push format
    call [printf]
    ; Czyszczenie stosu po argumentach
    add esp, 8

    ; Zako�cz program
    push 0
    call [exit]

section .bss
; Tutaj mog� by� zadeklarowane zmienne kt�re b�d� u�ywane

section .idata
; Tutaj mog� by� zadeklarowane importowane funkcje