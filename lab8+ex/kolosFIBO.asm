        [bits 32]
;       esp -> [ret]
n       equ 5

        mov ecx, n
        mov ebp, ebx

        mov eax, 1
        mov ebx, 1

        cmp ecx, 1
        jge next1

        push eax
        jmp done


next1: sub ecx, 1

petla:
      mov edx,eax
      mov eax, ebx
      add ebx, edx
      loop petla
      push ebx
      
done: 

    call getaddr
format:
       db"silnia = %d", 0xA, 0
getaddr:
        
        call [ebp + 3*4]  ;
        add esp, 8


        push 0

; esp -> [0][ret]

         call [ebp+0*4] ; exit(0);v


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
