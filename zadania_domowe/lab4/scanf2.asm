         [bits 32]
         
;        esp -> [ret]  ; ret - return address

extern   _scanf
extern   _printf
extern   _exit

section  .data

format      db "a = ", 0
specifier   db "%d", 0
number      dd 0
result      db "a = %d", 0

section  .text

global   _main

_main:
         push format

;        esp -> [format][ret]

         call _printf
         
         add esp, 4

;        esp -> [ret]
         
         push number
         push specifier
         
;        esp -> [specifier][number][ret]

         call _scanf  ; scanf(specifier, number)

         add esp, 2*4  ; esp += 8
         
;        esp -> [ret]

         push dword [number]
         push result

;        esp -> [result][ret]

         call _printf

         push 0
         call _exit




