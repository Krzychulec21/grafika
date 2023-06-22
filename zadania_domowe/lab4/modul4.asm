         [bits 32]

;        esp -> [ret]  ; ret - return address

extern   _scanf
extern   _printf
extern   _exit

section  .data

format      db "liczba = ", 0
specifier   db "%d", 0
number      dd 0
result      db "modul = %d", 0

section  .text

global   _main

_main:

         push format

;        esp -> [format][ret]

         call _printf  ; printf(format)
         
         add esp, 4  ; esp += 4
         
;        esp -> [ret]

         push number
         push specifier

;        esp -> [specifier][number][ret]

         call _scanf  ; scanf(specifier, number)
         
         add esp, 2*4  ; esp += 8
         
;        esp -> [ret]
         
         mov eax, dword [number]  ; esx = *(int*)number
         mov edx, eax
         
         cmp eax, 0     ; eax - 0
         jge nieujemna  ; jump if greater or equal
         neg edx
         
nieujemna:
         push edx
         push result

;        esp -> [result][edx][ret]

         call _printf  ; printf(result, edx)
         add esp, 2*4  ; esp += 8
         
;        esp -> [ret]

         push 0
         call _exit

