         [bits 32]

;        esp -> [ret]

n        equ 3

         mov ecx, n  ; ecx = n
         
.loop    push ecx  ; ecx -> stack

;        esp -> [ecx][ret]

         call getaddr

format:
         db "i = %d", 0xA, 0
getaddr:

;        esp -> [format][ecx][ret]

         call [ebx+3*4]  ; printf(format, ecx);  ;
         add esp, 1*4      ; esp += 4

;        esp -> [ecx][ret]

         pop ecx  ; ecx <- stack
        
         dec ecx     ; ecx--
         jne .loop   ; jump if not equal ecx != 0  ; ZF = 0
         
;        loop petla  ; równowa¿ny dwóm powy¿szym instrukcjom

         push 0         ; esp -> [0][ret]
         call[ebx+0*4]  ; exit(0)