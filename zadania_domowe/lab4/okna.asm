         [bits 32]

;        esp -> [ret]

x        equ 6
a        equ 5
b        equ 19
c        equ 12
d        equ 24

         mov eax, b  ; eax = b
         mov ecx, a  ; ecx = a

         sub eax, x  ; x - eax
         sub ecx, x  ; x - ecx

         mul ecx     ; eax = eax * ecx
         cmp eax, 0  ; eax - 0

         mov eax, b  ; eax = b
         mov ecx, a  ; ecx = a
         mov edx, x  ; edx = x

         push eax    ; stack -> eax
         push ecx    ; stack -> ecx
         push edx    ; stack -> edx
         
         jl in_range ; jump if less
         
;        esp -> [edx][ecx][eax][ret]

         call getaddr
         
format2:
         db "%d nie nalezy do (%d, %d)", 0xA, 0

in_range:
         call getaddr

format:
         db "%d nalezy do (%d, %d)", 0xA, 0

getaddr:

;        esp -> [format/format2][edx][ecx][eax][ret]

         call [ebx+3*4]  ; printf(format, edx, ecx, eax)
         add esp, 4*4    ; esp += 16

;        esp -> [ret]

         push 0
         
;        esp -> [0][ret]

         call [ebx+0*4]  ; exit(0)






