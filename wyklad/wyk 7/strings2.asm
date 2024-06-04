         [bits 32]

;        esp -> [ret]

         call $+5
addr:

;        esp -> [addr][ret]

         add dword [esp], format-addr  ; *(int*)esp += addr + format-addr = format

;        esp -> [format][ret]

         call [ebx+3*4]  ; printf(format);

         add dword [esp], format2-format  ; *(int*)esp += format + format2-format = format2

;        esp -> [format2][ret]

         call [ebx+3*4]  ; printf(format2);
         add esp, 4      ; esp = esp + 4

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0);

format   db "Hello world!", 0xA, 0
format2  db "Czy Ala ma kota?", 0xA, 0

