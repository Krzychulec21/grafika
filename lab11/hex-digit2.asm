         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

n        equ 10  ; n = 0..15

         call  getaddr

digits   db "0123456789ABCDEF"

getaddr:

;        esp -> [digits][ret]

         mov ebp, ebx  ; ebp = ebx
         
         mov ebx, [esp]  ; ebx = *(int*)esp = digits
         
         mov al, n  ; al = n
         
         xlat  ; al = *(char*)(ebx + al)  ; table lookup translation

         push eax  ; eax -> stack
         
;        esp -> [eax][digits][ret]

         call getaddr2  ; push on the stack the runtime address of format and jump to getaddr
format:
         db 'hexDigit = %c', 0xA, 0
getaddr2:

;        esp -> [format][eax][digits][ret]

         call [ebp+3*4]  ; printf('hexDigit = %c\n', eax);
         add esp, 3*4      ; esp = esp + 12

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebp+0*4]  ; exit(0);

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
