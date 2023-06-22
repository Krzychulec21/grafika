        [bits 32]

;       esp -> [ret]  ; ret - adres powrotu do asmloader



        sub esp, 8  ; esp = esp - 4  ; make room for int type result

;       esp -> [][ret]

        call getaddr
        
format  db"wynik = %f", 0xA, 0
length  equ $ - format

addr_a  dq 4.0  ; a  ; define double word
addr_b  dq 5.0  ; b  ; define double word
addr_c  dq 6.0  ; c  ; define double word

getaddr:

;       esp -> [format][][][ret]

        finit  ; fpu init

;       st = []

        mov eax, [esp]           ; eax = *(int*)esp = format
        lea eax, [eax + length]  ; eax = eax + length = format + length = addr_a

        fld qword [eax]     ; a -> st
        fld qword [eax+8]   ; b -> st
        fld qword [eax+16]  ; c -> st

;       st = [st0, st1, st2] = [c, b, a]  ; fpu stack

        fmulp st1  ; [st0, st1, st2] => [st0, st1 = st1*st0, st2] => [st1, st2] => [b*c, a]

;       st = [st0, st1] = [b*c, a]

        faddp st1  ; [st0, st1] => [st0, st1 = st1 + st0] => [st1] => [a + b*c]
        
;       st = [st0] = [a + b*c]

;                       +4
;       esp -> [format][][ret]

        fstp qword [esp+4]  ; *(int*)(esp + 4) <- st = [a + b*c]  ; fpu store top element
                                                                   ; and pop fpu stack
        
;       st = [] 

        call [ebx + 3*4]  ; printf(format, dword)
        add esp, 2*4
        
                  push 0         ; esp -> [0][ret]
         call [ebx+0*4] ; exit(0);

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
