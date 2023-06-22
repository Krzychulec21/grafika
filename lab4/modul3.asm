         [bits 32]
         
;        esp -> [ret]

         call getaddr

format:
       db "liczba = ", 0
       
getaddr:

;       esp -> [format][ret]

        call [ebx+3*4]  ; printf(format)
        
;       esp -> [liczba][ret]

        push esp  ; stack -> esp
        
;       esp -> [addr_liczba][liczba][ret]

        call getaddr2

format2:
        db "%d", 0

getaddr2:

;        esp -> [format2][addr_liczba][liczba][ret]

         call [ebx+4*4]  ; scanf(format2, addr_liczba)
         add esp, 2*4    ; esp += 8
         
;        esp -> [liczba][ret]

         mov eax, [esp]  ; eax = *(int*)esp
         mov edx, eax    ; edx = eax
         
         cmp eax, 0      ; eax - 0
         jge nieujemna   ; jump if grater or equal, if SF = 0
         neg edx         ; edx = -edx
         
nieujemna:
          
          push edx
          
;         esp -> [edx][liczba][ret]

          call getaddr3

format3:
        db "modul = %d", 0xA, 0

getaddr3:

;        esp -> [format3][liczba][ret]
         call [ebx+3*4]  ; printf(format3, edx)
         add esp, 3*4
         
;        esp -> [ret]

         push 0  ; esp -> 0
         
;        esp -> [0][ret]

         call[ebx+0*4]  ; exit(0)
