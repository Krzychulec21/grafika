         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

%ifdef COMMENT
0   1   2   3   4   5   6    indeksy

a   b   d
|---|---|
1   1   2   3   5   8   13   wartosci
    |---|---|
    a   b   d

Przesuniecie ramki:

a = b      ; a = 1
b = d      ; b = 2
d = a + b  ; d = 1 + 2 = 3
%endif

n        equ 3

         mov ebp, ebx  ; ebp = ebx
         
         mov ecx, n

         mov eax, 1  ; eax = 1
         mov ebx, 1  ; ebx = 1
         mov edx, 2  ; edx = 2
         
         cmp ecx, 0  ; ecx - 0
         jne next1   ; jump if not equal
         
         push eax  ; eax -> stack
         
;        esp -> [eax][ret]

         jmp done
         
next1    cmp ecx, 1  ; ecx - 1
         jne next2   ; jump if not equal
         
         push ebx  ; ebx -> stack
         
;        esp -> [eax][ret]

         jmp done

next2    cmp ecx, 2  ; edc - 2
         jne next3   ; jump if not equal

         push edx  ; edx -> stack
         
;        esp -> [edx][ret]

         jmp done
         
next3    sub ecx, 2  ; ecx -= 2

shift    mov eax, ebx  ; a = b
         mov ebx, edx  ; b = d
         add eax, ebx  ; a += b
         mov edx, eax  ; d = a + b
         
         loop shift
         
         push edx  ; edx -> stack

;        esp -> [edx][ret]

done:

         call getaddr  ; push on the stack the runtime address of format and jump to getaddr
format:
         db "fibo(n) = %d", 0xA, 0
getaddr:

;        esp -> [format][edx][ret]

         call [ebp+3*4]  ; printf('Hello World!\n');
         add esp, 2*4    ; esp = esp + 16

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
