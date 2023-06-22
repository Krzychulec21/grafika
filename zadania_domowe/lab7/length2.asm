         [bits 32]

;        esp -> [ret]

n        equ -10000

         mov ecx, 0  ; ecx = 0
         
         mov ebp, 10  ; ebp = 10

         mov eax, n  ; eax = n
petla    cdq         ; edx:eax = eax  ; signed convertion

         idiv ebp  ; eax = edx:eax / ebp  ; iloraz
                   ; edx = edx:eax % ebp  ; reszta

         inc ecx  ; ecx++

         cmp eax, 0  ; eax - 0  ; ZF affected
         jl petla    ; jump if less, ZF = 0

         push ecx  ; ecx -> stack
         
;        esp -> [ecx][ret]

         call getaddr
format:
         db "length = %u", 0xA, 0
getaddr:

;        esp -> [format][eax][ret]

         call [ebx+3*4]  ; printf(format, ecx);
         add esp, 2*4    ; esp += 8

;        esp -> [ret]

         push 0         ; esp -> [0][ret]
         call[ebx+0*4]  ; exit(0)