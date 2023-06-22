         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

a        equ 480
b        equ 18

         mov eax, a  ; eax = a

         call getaddr
addr_b:
       dd b
getaddr:

;       esp -> [addr_b][ret]

        mov ecx, [esp]  ; ecx = *(int*)esp = addr_b

        add eax, [ecx]  ; eax += *(addr_b) = b

        push eax        ; eax -> esp
        
;       esp -> [eax][addr_b][ret]

        call getaddr2

format:
         db "suma = %d", 0xA, 0
getaddr2:

;        esp -> [format][eax][addr_b][ret]

         call [ebx+3*4]  ; printf('a = %d\n', suma);
         add esp, 3*4    ; esp = esp + 8

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0);

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
