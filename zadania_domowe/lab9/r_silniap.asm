%ifdef COMMENT
silnia(n) = 1 * 2 * ... * n

0! = 1
n! = n*(n-1)!

silnia(0) = 0
silnia(n) = n * silnia(n-1)

silnia(0) = 1
silnia(1) = 1
silnia(2) = 2
%endif

         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

n        equ 6

         mov ecx, n  ; ecx = n

         call silnia   ; eax = silnia(ecx) ; fastcall

addr:

;        esp -> [ret]

         push eax

;        esp -> [eax][ret]

         call getaddr
format:
         db "silnia = %i", 0xA, 0
getaddr:

;        esp -> [format][eax][ret]

         call [ebx+3*4]  ; printf("suma = %i\n", eax);
         add esp, 2*4    ; esp = esp + 8

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebx+0*4]  ; exit(0);

;        eax silnia(ecx)

silnia   cmp ecx, 1    ; ecx - 1           ; ZF affected
         jg rec        ; jump if greater ; jump if ZF = 0
         mov eax, 1    ; eax = 1
         ret

rec      push ecx      ; ecx -> stack = n
         dec ecx       ; ecx = ecx - 1 = n-1
         dec ecx       ; ecx = ecx - 1 = n-2
         call silnia   ; eax = silnia(ecx) = silnia(n-2)
         pop ecx       ; ecx <- stack = n
         mul ecx       ; eax = eax * ecx = silnia(n-1) * n
         ret
         
;        mul arg  ; edx:eax = eax*arg

; silnia(0) = 1
; silnia(n) = n * silnia(n-1)

%ifdef COMMENT
eax = silnia(ecx)

* silnia(1) =         * silnia(1) = 1
  ecx -> stack = 1      ecx -> stack = 1
  ecx = ecx - 1 = 0     ecx = ecx - 1 = 0
  eax = silnia(0) =     eax = silnia(0) = 1
  ecx <- stack = 1      ecx <- stack = 1
  eax = eax * ecx =     eax = eax * ecx = 1 * 1 = 1
  return eax =          return eax = 1

* silnia(0) =         * silnia(0) = 1
  eax = 1               eax = 1
  return eax = 1        return eax = 1
%endif

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
