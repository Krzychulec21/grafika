         [bits 32]

;        esp -> [ret]  ; adres powrotu do asmloader

a        equ 2147483648
b        equ 1
c        equ 2
d        equ 2

         mov eax, a  ; eax = a
         mov edx, b  ; ecx = b

         mul edx  ; edx:eax = eax*edx

         mov esi, edx  ; esi = edx
         mov edi, eax  ; edi = eax
         
;        a*b = edx:eax = esi:edi
         
         mov eax, c  ; eax = c
         mov edx, d  ; ecx = d

         mul edx  ; edx:eax = eax*ecx

         add edi, eax  ; edi += eax
         adc esi, edx  ; edx += esi
         
         push esi
         push edi

         call getaddr
format:
       db "a*b+c*d = %llu", 0xA, 0
getaddr:
        
;       esp -> [format][esi][edi][ret]

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
