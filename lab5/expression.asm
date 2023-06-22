         [bits 32]

;        esp -> [ret]
         
a        equ 48
b        equ 2
c        equ 3

         mov eax, b  ; eax = b
         mov ecx, c  ; ecx = c
            
;        Mno¿enie bez znaku

         mul ecx       ; eax = ecx * eax

         mov edx, a  ; edx = a
         add eax, edx  ;eax += edx

         push eax      ; eax -> stack

;        esp -> [eax][ret]
         
         call getaddr
         
format:
       db "a+b*c = %u", 0xA, 0

getaddr:

;        esp -> [format][eax][ret]

         call [ebx+3*4]  ; printf(format, eax)
         add esp, 2*4    ; ebx += 8
         
;        esp -> [ret]

         push 0  ; 0 -> stack
         
;        esp -> [0][ret]

         call [ebx+0*4]  ; exit(0)