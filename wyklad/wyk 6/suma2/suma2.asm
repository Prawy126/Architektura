         [bits 32]

section  .text

global   _suma2

_suma2:

;                     +4 +8
;        esp -> [addr][a][b]

         mov eax, [esp+4]  ; eax = *(int*)(esp+4) = a
         mov ebx, [esp+8]  ; ebx = *(int*)(esp+8) = b

         add eax, ebx      ; eax = eax + ebx = a + b

         ret               ; return eax
