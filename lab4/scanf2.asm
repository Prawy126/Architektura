assembly
Copy code
[bits 32]

section .data
format db "Enter a number: ", 0
input_format db "%d", 0    ; Format dla scanf do czytania liczby ca³kowitej
number dd 0                ; Miejsce na zmienn¹ gdzie scanf zapisze wartoœæ

section .text
global _start

_start:
    ; Wydrukuj monit
    push format
    call [printf]
    add esp, 4

    ; Przygotowanie argumentów dla scanf - adres zmiennej number
    push number
    push input_format
    call [scanf]
    ; Czyszczenie stosu po argumentach (2 argumenty po 4 bajty ka¿dy)
    add esp, 8

    ; Wydrukuj wprowadzon¹ wartoœæ
    push number
    push format
    call [printf]
    ; Czyszczenie stosu po argumentach
    add esp, 8

    ; Zakoñcz program
    push 0
    call [exit]

section .bss
; Tutaj mog¹ byæ zadeklarowane zmienne które bêd¹ u¿ywane

section .idata
; Tutaj mog¹ byæ zadeklarowane importowane funkcje