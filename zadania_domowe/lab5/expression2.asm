         [bits 32]

;        esp -> [ret]  ; adres powrotu do asmloader

a        equ 4
b        equ 5
c        equ 6

         mov eax, b    ; eax = b
         mov edx, c    ; edx = c

         mul edx  ; edx:eax = eax * ecx

         mov esi, eax  ; esi = eax
         mov edi, edx  ; edi = edx
         
         mov eax, a

         add esi, eax  ; esi += eax
         adc edi, edx  ; edi += edx + CF
         
         push edi
         push esi

;        esp -> [eax][edx][ret]
         
         call getaddr
format:
       db "a+b*c = %llu", 0xA, 0
getaddr:
        
;       esp -> [format][eax][edx][ret]

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
