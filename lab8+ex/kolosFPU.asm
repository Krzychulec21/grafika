        [bits 32]
;       esp -> [ret]

        sub esp, 8  ; esp = esp - 8  ; make room for double type result
        
;       esp -> [][][ret]

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

        mov eax, [esp]   ; eax = *(int*)esp = format
        lea eax, [eax+length]  ; eax = eax + length = format + length = addr_a
        
        fld qword [eax]  ; c -> st
        fld qword [eax+8]  ; b -> st
        fld qword [eax+16]  ; a -> st
        
;       st = [st0, st1, st2] = [c, b, a]
        
        fmulp st1  ; st1 = st0*st1 => st = [st0,st1] => [c*b, a]
        
;       st = [st0, st1] = [c*b, a]

        faddp st1  ; st1 = st0+st1 => st = [st0] => [c*b + a]
        
;       st = [st0] = [c*b + a]

        fstp qword [esp+4]
;                      +4 +8
;       esp -> [format][][][ret]
        
        call  [ebx+3*4]
        add esp, 8
        

push 0         ; esp -> [0][ret]
         call [ebx+0*4] ; exit(0);v


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
