         [bits 32]
         
;        esp -> [ret]

a        equ -2147483648
b        equ -1

;        edx:eax
;        edi:esi +
;        -------
;        edi:esi

         mov eax, a  ; eax = a

         cdq  ; edx:eax = eax (a)  ; signed convertion

         mov edi, edx  ; edi = edx
         mov esi, eax  ; esi = eax
         
         mov eax, b  ; eax = b

         cdq  ; edx:eax = eax (b)  ; signed convertion

         add esi, eax  ; esi += eax
         adc edi, edx  ; edi += edx + CF

         push edi  ; esi -> stack
         push esi  ; edi -> stack
         
;        esp -> [format][esi][edi][ret]
         
         call getaddr

format:
         db "suma = %lld", 0xA, 0

getaddr:

;        esp -> [format][esi][edi][ret]

         call [ebx+3*4]  ; printf(format, edi:esi)
         add esp, 3*4    ; esp += 12

;        esp -> [ret]

         push 0

;        esp -> [0][ret]

         call [ebx+0*4]  ; exit(0)