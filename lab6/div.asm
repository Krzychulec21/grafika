         [bits 32]
         
;        esp -> [ret]

a        equ 8
b        equ 4

         mov edx, 0  ; edx = 0
         mov eax, a  ; eax = a
         
         mov ecx, b  ; ecx = b
         
         div ecx     ; eax = edx:eax / ecx  ; iloraz
                     ; edx = edx:eax % ecx  ; reszta

;        div arg     ; eax = edx:eax / arg  ; iloraz
                     ; edx = edx:eax % arg  ; reszta
                     
         push edx  ; edx -> stack
         push eax  ; eax -> stack
         
;        esp -> [eax][edx][ret]
         
         call getaddr

format:
         db "iloraz = %u", 0xA
         db "reszta = %u", 0xA, 0

getaddr:

;        esp -> [format][eax][edx][ret]

         call [ebx+3*4]  ; printf(format, eax, edx)
         add esp, 3*4    ; esp += 12

;        esp -> [ret]

         push 0

;        esp -> [0][ret]

         call [ebx+0*4]  ; exit(0)