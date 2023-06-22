         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

a        equ 10

         mov eax, a  ; eax = a

         xor eax, ~0  ; eax = eax ^ ~0
         inc eax  ; eax++
         
         push eax  ; eax -> stack

;        esp -> [eax][ret]

         mov ecx, a  ; eax = a
         
         not ecx  ; eax = ~eax
         inc ecx  ; eax++
         
         push ecx  ; eax -> stack
         
;        esp -> [ecx][eax][ret]

         mov edx, a
         
         neg edx  ; edx = -edx
         
         push edx  ; edx -> stack

;        esp -> [edx][ecx][eax][ret]

         call getaddr  ; push on the stack the runtime address of format and jump to getaddr
format:
         db "-a = %d", 0xA,
         db "-a = %d", 0xA,
         db "-a = %d", 0
getaddr:

;        esp -> [format][edx][ecx][eax][ret]

         call [ebx+3*4]  ; printf(format, edx, ecx, eax);
         add esp, 4*4    ; esp = esp + 16

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
