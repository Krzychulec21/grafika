         [bits 32]
         
;        esp -> [ret]

a        equ 4294967296
b        equ 3

%define  ULLONG_MAX 18446744073709551615

%define  UINT_MAX 4294967295

a_l      equ a % (UINT_MAX + 1)
a_h      equ a / (UINT_MAX + 1)

         mov edx, a_h  ; edx = a_h
         mov eax, a_l  ; eax = a_l
         
         mov ecx, b  ; ecx = b
         
         div ecx     ; eax = edx:eax / ecx  ; iloraz
                     ; edx = edx:eax % ecx  ; reszta

;        div arg     ; eax = edx:eax / arg  ; iloraz
                     ; edx = edx:eax % arg  ; reszta
                     
         push edx  ; edx -> stack
         push eax  ; eax -> stack
         
;        esp -> [eax][edx][ret]
         
         call getaddr

format:
         db "iloraz = %u", 0xA
         db "reszta = %u", 0xA, 0

getaddr:

;        esp -> [format][eax][edx][ret]

         call [ebx+3*4]  ; printf(format, eax, edx)
         add esp, 3*4    ; esp += 12

;        esp -> [ret]

         push 0

;        esp -> [0][ret]

         call [ebx+0*4]  ; exit(0)