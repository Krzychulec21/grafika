         [bits 32]

;        esp -> [ret]

x        equ 15
a        equ 10
b        equ 20

         mov eax, x  ; eax = x
         mov edx, a  ; edx = a
         mov ebp, b  ; ebp = b

         cmp eax, edx       ; eax - edx
         jge wiekszy_rowny  ; jump if greater or equal
         
         push ebp  ; stack -> ebp
         push edx  ; stack -> edx
         push eax  ; stack -> eax

         call getaddr2
         
format2:
        db "%d nie nalezy do [%d, %d]", 0xA, 0

wiekszy_rowny:

         cmp eax, ebp       ; eax - ebp
         jnge w_przedziale  ; jump if not greater or equal
         
         push ebp  ; stack -> ebp
         push edx  ; stack -> edx
         push eax  ; stack -> eax

         call getaddr2
         
format3:
        db "%d nie nalezy do [%d, %d]", 0xA, 0

w_przedziale:

         push ebp  ; stack -> ebp
         push edx  ; stack -> edx
         push eax  ; stack -> eax

         call getaddr

format:
       db "%d nalezy do [%d, %d]", 0xA, 0
       
getaddr:

;       esp -> [format][eax][edx][ebp][ret]

        call [ebx+3*4]  ; printf(format, eax, edx, ebp)
        add esp, 4*4    ; esp += 16
        
;       esp -> [ret]

        push 0  ; stack -> 0
        
;       esp -> [0][ret]

        call [ebx+0*4]  ; exit(0)

getaddr2:

;       esp -> [format2/format3][eax][edx][ebp][ret]

        call [ebx+3*4]  ; printf(format, eax, edx, ebp)
        add esp, 4*4    ; esp += 16
        
;       esp -> [ret]

        push 0  ; stack -> 0
        
;       esp -> [0][ret]

        call [ebx+0*4]  ; exit(0)
