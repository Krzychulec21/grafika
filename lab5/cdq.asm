         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         mov eax, 0x7FFFFFFF  ; eax = 0x7FFFFFFF ; liczba dodatnia w kodzie U2

         cdq  ; edx:eax = (eax >= 0 ? 0:eax : -1:eax) = 0:eax = 0x00000000:0x7FFFFFFF
              ;
              ; convert doubleword to quadword

         call print  ; fastcall

addr1:

;        esp -> [ret]

         mov eax, 0x80000000  ; eax = 0x80000000 ; liczba ujemna w kodzie U2

         cdq  ; edx:eax = (eax >= 0 ? 0:eax : -1:eax) = -1:eax = 0xFFFFFFFF:0x80000000
              ;
              ; convert doubleword to quadword

         call print  ; fastcall

addr2:

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0);

print:

;        esp -> [addr_][ret]

         push edx
         push eax

;        esp -> [eax][edx][addr_][ret]

         call getaddr
format:
         db "edx:eax = %016llX", 0xA, 0
getaddr:

;        esp -> [format][eax][edx][addr_][ret]

         call [ebx+3*4]  ; printf("edx:eax = %016llX\n", edx:eax);
         adc esp, 3*4    ; esp = esp + 12

;        esp -> [addr_][ret]

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