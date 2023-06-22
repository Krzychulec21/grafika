         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

a        equ 0y1001_1001
n        equ 1

         mov al, a      ; al = a

         mov esi, eax   ; esi = eax ; store eax

         call p_binary  ; fastcall

addr1:

;        esp -> [ret]

         mov eax, esi  ; eax = esi ; restore eax

         shl al, n  ; CF = al >> 7 ; al = al << n

;        1 = c <- [10011001] <- 0
;                 [00110010]

;        c[10011001]0
;         //////////
;        1[00110010]

         mov ecx, 0  ; ecx = 0
         adc ecx, 0  ; ecx = ecx + 0 + CF = CF

         mov esi, ecx  ; esi = ecx ; store ecx

         call p_binary  ; fastcall

addr2:

;        esp -> [ret]

         push esi

;        esp -> [esi][ret]

         call getaddr1
format1:
         db "CF = %u", 0xA, 0
getaddr1:

;        esp -> [format1][esi][ret]

         call [ebx+3*4]  ; printf("CF = %u\n", esi);
         adc esp, 2*4    ; esp = esp + 8

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0);

p_binary:

;        esp -> [addr_][ret]

         mov ecx, 8  ; ecx = 8
         mov edx, 0  ; edx = 0

petla    shl edx, 4  ; edx = edx << 4 = edx*16
         shl al, 1   ; al = al << 1
         adc edx, 0  ; edx = edx + 0 + CF

         loop petla

         push edx

;        esp -> [edx][addr_][ret]

         call getaddr2
format2:
         db "al = %08x", 0xA, 0
getaddr2:

;        esp -> [format2][edx][addr_][ret]

         call [ebx+3*4] ; printf("al = %08x\n", edx);
         add esp, 2*4   ; esp = esp + 8

;        esp -> [addr][ret]

         ret

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