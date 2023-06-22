         [bits 32]

;        esp -> [ret]  ; adres powrotu do asmloader

a        equ 1
b        equ -2147483647
c        equ 2

         mov eax, b    ; eax = b
         mov edx, c    ; edx = c

         imul edx  ; edx:eax = eax * ecx

         mov edi, eax  ; edi = eax
         mov esi, edx  ; esi = edx

         mov eax, a  ; eax = a

         cdq  ; edx:eax = eax = a
         
         add edi, eax  ; edi += eax
         adc esi, edx  ; esi += edx

         push esi
         push edi
         
;        esp -> [edi][esi][ret]

         call getaddr
format:
       db "a+b*c = %lld", 0xA, 0
getaddr:
        
;       esp -> [format][edi][esi][ret]

        call [ebx+3*4]
        add esp, 3*4  ; esp += 12
        
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
