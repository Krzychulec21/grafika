         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         push 'H'

;                             +4
;        esp -> ['H' 00 00 00][ret]

         call [ebx+1*4]  ; putchar('H');
         add esp, 4      ; esp = esp + 4

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

; ZADANIE DOMOWE
; jaki adres ma instrukcja add esp, 4 ?                         Odp: 00000005
; ile bajtów ma instrukcja add esp, 4 ?                         Odp: 83 C4 04, 3 bajty
; jaki kod rozkazu ma instrukcja add esp, 4 ?                   Odp: 83 C4
; ile bajtów zajmuje kod rozkazu instrukcji add esp, 4 ? *      Odp: 2 bajty
; jaki kod ma argument instrukcji add esp, 4 ? *                Odp: 04

; jaki adres ma instrukcja call [ebx+0*4] ?                     Odp: 0000000A
; ile bajtów ma instrukcja call [ebx+0*4] ?                     Odp: FF 13, 2 bajty
; jaki kod rozkazu ma instrukcja call [ebx+0*4] ?               Odp: FF 13
; ile bajtów zajmuje kod rozkazu instrukcji call [ebx+0*4] ?    Odp: 2 bajty
; czy instrukcja call [ebx+0*4] ma kod argumentu?               Odp: Nie
