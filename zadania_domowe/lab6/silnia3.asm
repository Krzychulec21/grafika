         [bits 32]

;        esp -> [ret]

n        equ 4

         mov ecx, n  ; ecx = n
         mov eax, 1  ; eax = 1
         
         test ecx, ecx  ; ecx & ecx
         jz break       ; jump if zero
         
         mov dl, cl
         test dl, 01h  ; dl & 0000 0001  ; check if even number
         jz even

odd:     mul ecx  ; edx:eax = eax*ecx

         dec ecx
         dec ecx
         cmp ecx, 1  ; ecx - 1
         jne odd

break    push eax  ; eax -> stack

;        esp -> [eax][ret]

         call getaddr

format:
         db "n! = %d", 0xA, 0

even     mul ecx  ; edx:eax = eax*ecx

         dec ecx
         dec ecx
         jne even
         
         jmp break

getaddr:

;        esp -> [format][eax][ret]

         call [ebx+3*4]  ; printf(format, ecx);
         add esp, 2*4    ; esp += 8

;        esp -> [ret]

         push 0         ; esp -> [0][ret]
         call[ebx+0*4]  ; exit(0)