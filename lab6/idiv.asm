         [bits 32]

;        esp -> [ret]

a        equ -1
b        equ 10

         mov eax, a  ; eax = a
         
         cdq  ; edx:eax = eax  ; signed convertion

         mov ecx, b  ; ecx = b

         idiv ecx    ; eax = edx:eax / ecx  ; iloraz
                     ; edx = edx:eax % ecx  ; reszta

;        idiv arg    ; eax = edx:eax / arg  ; iloraz
                     ; edx = edx:eax % arg  ; reszta

         push edx  ; edx -> stack
         push eax  ; eax -> stack
         
;        esp -> [eax][edx][ret]
         
         call getaddr

format:
         db "iloraz = %d", 0xA
         db "reszta = %d", 0xA, 0

getaddr:

;        esp -> [format][eax][edx][ret]

         call [ebx+3*4]  ; printf(format, eax, edx)
         add esp, 3*4    ; esp += 12

;        esp -> [ret]

         push 0

;        esp -> [0][ret]

         call [ebx+0*4]  ; exit(0)