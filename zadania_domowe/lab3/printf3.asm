         [bits 32]

;        esp -> [ret]  ; adres powrotu do asmloadera

a        equ 1
b        equ 2

         push b  ; b -> stack
         push a  ; a -> stack
         
;        esp -> [a][b][ret]

         call getaddr

format:
       db "a = %d, b = %d", 0xA, 0

getaddr:
        
;       esp -> [format][a][b][ret]

        call [ebx+3*4]  ; printf("a = %d, b = %d", a, b)
        add esp, 3*4    ; esp += 12
        
;       esp - > [ret]

        push 0          ; esp -> [0][ret]
        call [ebx+0*4]  ; exit(0)