         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

a        equ 3
b        equ 5


         mov esi, a    ; eax = a
         mov edi, b    ; ebx = b

         push edi      ; ebx -> stack
         push esi      ; eax -> stack

;        esp -> [esi][edi][ret]

         call getaddr  ; push on the stack the runtime address of format and jump to getaddr
format:
         db "(esi, edi) = (%d, %d)", 0xA, 0
getaddr:

;        esp -> [format][esi][edi][ret]

         call [ebx+3*4]  ; printf(format, esi, edi)
         add esp, 3*4    ; esp += 12

;        esp -> [ret]

         xchg esi, edi
         
         push edi  ; edi -> stack
         push esi  ; esi -> stack
         
;        esp -> [esi][edi][ret]
         
         call getaddr2


         
format2:
        db "(esi, edi) = (%d, %d)", 0xA, 0

getaddr2:

;        esp -> [format2][esi][edi][ret]

         call [ebx+3*4]  ; printf(format, esi, edi)
         add esp, 3*4    ; esp += 12

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0);

;

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
