         [bits 32]

;        esp -> [ret]

n        equ 5

         mov ecx, n  ; ecx = n
         mov eax, 1  ; eax = 1
         
         test ecx, ecx  ; ecx & ecx
         jz break       ; jump if zero

petla    mul ecx  ; edx:eax = eax*ecx
         dec ecx
         dec ecx
         cmp ecx, 0
         jg petla


break    push eax  ; eax -> stack

;        esp -> [eax][ret]

         call getaddr
format:
         db "n! = %d", 0xA, 0
getaddr:

;        esp -> [format][eax][ret]

         call [ebx+3*4]  ; printf(format, ecx);
         add esp, 2*4    ; esp += 8

;        esp -> [ret]

         push 0         ; esp -> [0][ret]
         call[ebx+0*4]  ; exit(0)