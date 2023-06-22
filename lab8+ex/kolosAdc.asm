 [bits 32]

        call printf1
format1:
        db "Podaj a: ", 0
printf1:
        call [ebx+3*4]
        push esp

        call scanf1
format2:
        db "%d", 0
scanf1:
        call [ebx+4*4]
        ; esp -> [a][ret]
        add esp, 2*4

        call printf2
format3:
        db "Podaj b: ", 0
printf2:
        call [ebx+3*4]
        push esp

        call scanf2
format4:
        db "%d", 0
scanf2:
        call [ebx+4*4]
        add esp, 2*4

        ; esp -> [b][a][ret]

        mov eax, -1
        pop ecx
        mov edx, 0
        imul ecx
        push eax

        ; esp -> [-b][a][ret]
        pop eax
        pop ecx
        mov edx, 0
        cdq
        idiv ecx
        push eax

        call printf3
format5:
        db "x = %d", 0xA, 0
printf3:
        call [ebx+3*4]

        add esp, 2*4

        push 0
        call [ebx+0*4]