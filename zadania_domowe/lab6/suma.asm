         [bits 32]

;        esp -> [ret]

n        equ 4

         mov ecx, n    ; ecx = n
         mov eax, 0  ; eax = 0
         
         test ecx, ecx  ; ecx & ecx
         jz break       ; jump if zero

petla    add eax, ecx  ; edx:eax = eax*ecx

         loop petla

break    push eax  ; eax -> stack

;        esp -> [eax][ret]

         call getaddr
format:
         db "suma(n) = %d", 0xA, 0
getaddr:

;        esp -> [format][eax][ret]

         call [ebx+3*4]  ; printf(format, ecx);
         add esp, 2*4    ; esp += 8

;        esp -> [ret]

         push 0         ; esp -> [0][ret]
         call[ebx+0*4]  ; exit(0)