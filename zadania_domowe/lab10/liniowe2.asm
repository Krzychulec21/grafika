         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         call getaddr  ; push on the stack the runtime address of format and jump to getaddr
format:
         db "a = ", 0
getaddr:

;        esp -> [format][ret]

         call [ebx+3*4]  ; printf("a = ");

;        esp -> [a][ret] ; zmienna a, adres format nie jest juz potrzebny

         push esp  ; esp -> stack

;        esp -> [addr_a][a][ret]
         
         call getaddr2
format2:
       db "%d", 0
getaddr2:

;        esp -> [format2][addr_a][a][ret]

         call [ebx+4*4]  ; scanf(format2, addr_a)
         add esp, 2*4    ; esp += 8

;        esp -> [a][ret]

         call getaddr3
format3:
         db "b = ", 0
getaddr3:

;        esp -> [format3][a][ret]

         call [ebx+3*4]  ; printf("b = ")
         
;        esp -> [b][a][ret]
         
         push esp  ; esp -> stack
         
;        esp -> [addr_b][b][a][ret]

         call getaddr4
format4:
         db "%d", 0

getaddr4:  

;        esp -> [format4][addr_b][b][a][ret]

         call [ebx+4*4]  ; scanf(format4, addr_b)
         add esp, 2*4    ; esp += 8
         
;        esp -> [b][a][ret]
         
         call getaddr5
format5:
         db "b = %d", 0xA
         db "a = %d", 0

getaddr5:
         
;        esp -> [format5][b][a][ret]

         call [ebx+3*4]  ; printf(format5, b, a)
         add esp, 3*4    ; esp += 4
         
         

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
