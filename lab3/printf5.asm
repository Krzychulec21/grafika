         [bits 32]
         
;        esp -> [ret]

a        equ 1
b        equ 2

         call print
addr:

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0)

print:

;        esp -> [addr][ret]

         push b  ; b -> stack
      
;        esp -> [b][addr][ret]

         push a  ; a -> stack
      
;        esp -> [a][b][addr][ret]

         call getaddr

format:
         db "a = %d, b = %d", 0xA, 0

getaddr:
        
;       esp -> [format][ebx][eax][addr][ret]

        call [ebx+3*4]  ; printf("a = %d, b = %d", a, b)
        add esp, 3*4    ; esp += 12

;       esp - > [addr][ret]

        ret