         [bits 32]

section  .text

global   _suma3

_suma3:

;                     +4 +8
;        esp -> [addr][a][b]

         push ebp  ; esp = esp - 4 ; *(int*)esp = ebp ;  tworzymy ramke stosu

;                    +4    +8 +12
;        esp -> [ebp][addr][a][b]

         mov ebp, esp  ; ebp = esp

;                    +4    +8 +12
;        ebp -> [ebp][addr][a][b]

         mov eax,[ebp+8]   ; eax = *(int*)(ebp+8) = a
         add eax,[ebp+12]  ; eax = eax + *(int*)(ebp+12) = a + b

         mov esp, ebp  ; esp = ebp  ; usuwamy ramke stosu

;                    +4    +8 +12
;        esp -> [ebp][addr][a][b]

         pop ebp  ; ebp = *(int*)esp ; esp = esp + 4 ; przywracamy poczatkowe ebp

;                     +4  +8
;        esp -> [addr][a][b]

         ret  ; return eax

