         [bits 32]

;        esp -> [ret]  ; adres powrotu do asmloader

a        equ 37152635
b        equ 9929

         mov eax, a  ; eax = a
         sub eax, b  ; eax -= b
         
         push eax
         
;        esp -> [eax][ret]

         call getaddr
format:
       db "roznica = %d", 0xA, 0
getaddr:
        
;       esp -> [format][eax][ret]

        call [ebx+3*4]  ; printf("roznica = %d", eax)
        add esp, 2*4    ; esp += 8
        
        push 0          ; esp -> [0][ret]
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
; To co funkcja zwr�ci jest w EAX.
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
