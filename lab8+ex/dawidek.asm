    [bits 32]

        call printX
formatX:
        db "x = ", 0

printX:
        call [ebx+3*4]
        ; esp -> [formatX][ret]
        push esp
        ; esp -> [addr_x][x][ret]

        call getaddrX

getX:
        db "%d", 0

getaddrX:
        ; esp -> [formatX][addr_x][x][ret]
        mov eax, esp ; ecx = esp
        call [ebx+4*4]
        add esp, 2*4
        ; esp -> [x][ret]
        ; st0 = x;
        ;add esp, 1*4
        ;sub esp, 2*4


licz:
        mov ecx, eax
petla:
        mov eax, [esp]
        mov edx, 0
        div ecx
        cmp edx, 0
        je podzielna
        loop petla


podzielna:
          push ecx
; esp -> [ecx][x][ret]
          call getaddr
format_podzielna:
          dd"liczba przez ktroa sie dzieli: %d", 0xA
getaddr:

; esp -> [format_podzielna][ecx][x][ret]

          call [ebx+3*4] ; putchar('H');
          add esp, 1*4     ; esp -> [ret]
          
          cmp ecx, 0
          je


           push 0         ; esp -> [0][ret]
           call [ebx+0*4] ; exit(0);
