         [bits 32]
         
;        esp -> [ret]


;          0:eax
;        + 0:esi
;        -------
;        edi:esi

a        equ 4294967295
b        equ 1

         mov eax, a  ; eax = a
         mov esi, b  ; ecx = b

         add esi, eax  ; esi += eax

         mov edi, 0  ; edi = 0
         adc edi, 0  ; edi += 0 + CF
         
         push edi  ; esi -> stack
         push esi  ; edi -> stack
         
;        esp -> [format][esi][edi][ret]
         
         call getaddr

format:
         db "suma = %llu", 0xA, 0

getaddr:

;        esp -> [format][esi][edi][ret]

         call [ebx+3*4]  ; printf(format, edi:esi)
         add esp, 3*4    ; esp += 12

;        esp -> [ret]

         push 0

;        esp -> [0][ret]

         call [ebx+0*4]  ; exit(0)