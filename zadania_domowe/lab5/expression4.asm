         [bits 32]

;        esp -> [ret]  ; adres powrotu do asmloader

a        equ 1
b        equ 2
c        equ 3
d        equ 4

         mov eax, a  ; eax = a
         mov ecx, b  ; ecx = b

         mul ecx  ; ecx:eax = eax*ecx
         
         mov esi, eax  ; esi = eax
         
         mov eax, c  ; eax = c
         mov edx, d  ; edx = d

         mul edx  ; ecx:eax = eax*ecx

         add eax, esi  ; eax += esi
         
         push eax  ; eax -> stack

;        esp -> [eax][ret]

         call getaddr
format:
       db "a*b+c*d = %u", 0xA, 0
getaddr:
        
;       esp -> [format][eax][ret]

        call [ebx+3*4]
        add esp, 2*4  ; esp += 8
        
        push 0  ; esp -> [0][ret]
        call [ebx+0*4]


; asmloader API
;
; ESP wskazuje na prawidlowy stos
; argumenty funkcji wrzucamy na stos
; EBX zawiera pointer na tablice API
;
; call [ebx + NR_FUNKCJI*4] ; wywolanie funkcji API
;
; NR_FUNKCJI:
;
; 0 - exit
; 1 - putchar
; 2 - getchar
; 3 - printf
; 4 - scanf
;
; To co funkcja zwróci jest w EAX.
; Po wywolaniu funkcji sciagamy argumenty ze stosu.
;
; https://gynvael.coldwind.pl/?id=387

%ifdef COMMENT

ebx    -> [ ][ ][ ][ ] -> exit
ebx+4  -> [ ][ ][ ][ ] -> putchar
ebx+8  -> [ ][ ][ ][ ] -> getchar
ebx+12 -> [ ][ ][ ][ ] -> printf
ebx+16 -> [ ][ ][ ][ ] -> scanf

%endif
