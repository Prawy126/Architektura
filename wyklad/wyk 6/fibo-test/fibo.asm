%ifdef COMMENT
0   1   2   3   4   5   6    indeksy

a   b
|---|
1   1   2   3   5   8   13   wartosci
    |---|
    b  a+b

         xadd eax, ebx ; (eax, ebx) = (eax + ebx, eax) <=> tmp = eax
                       ;                                   eax = eax + ebx
                       ;                                   ebx = tmp
         Hint:

         xadd (b, a) = (a+b, b)
%endif

         [bits 32]

section  .text

global   _fibo

_fibo:

;                     +4
;        esp -> [addr][n]

         mov ecx, [esp+4]  ; ecx = *(int*)(esp+4)

         mov eax, 1  ; eax = 1
         mov ebx, 1  ; ebx = 1

         cmp ecx, 2  ; ecx - 2                ; OF SF ZF AF PF CF affected
         jae next    ; jump if above or equal ; jump if CF = 0

         ret  ; return eax

next     dec ecx  ; ecx--

shift    xadd ebx, eax  ; (ebx, eax) = (eax + ebx, ebx)

         loop shift

         mov eax, ebx  ; eax = ebx

         ret  ; return eax
