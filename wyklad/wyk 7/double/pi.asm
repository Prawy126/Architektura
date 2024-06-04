         [bits 32]

section  .text

global   _pi

_pi:

;        esp -> [addr]

         finit  ; fpu init
         
;        st = []

         fldpi  ; fpu load pi

;        st = [st0] = [pi]

         ret  ; return st0

