%ifdef COMMENT
fibo(n) = 1 + 1 + 2 + ... + n-1 + n-2

fibo(0) = 1
fibo(n) = fibo(n-1) + fibo(n-2)

fibo(0) = 1
fibo(1) = 1
fibo(2) = 2
fibo(3) = 3
fibo(4) = 5
fibo(5) = 8
%endif

         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

n        equ 6

         mov ecx, n  ; ecx = n
         mov ebp, ebx
         mov ebx, 0

         call fibo   ; eax = fibo(ecx) ; fastcall

addr:

;        esp -> [ret]

         push eax

;        esp -> [eax][ret]

         call getaddr
format:
         db "fibo(n) = %i", 0xA, 0
getaddr:

;        esp -> [format][eax][ret]

         call [ebp+3*4]  ; printf("fibo = %i\n", eax);
         add esp, 2*4    ; esp = esp + 8

;        esp -> [ret]

         push 0          ; esp -> [0][ret]
         call [ebp+0*4]  ; exit(0);

;        eax fibo(ecx)

fibo     cmp ecx, 0    ; ecx - 0           ; ZF affected
         jne next       ; jump if not equal ; jump if ZF = 0
         mov eax, 1  ; eax = ecx = 0
         ret

next     cmp ecx, 1
         jne rec
         mov eax, ecx
         ret

rec      dec ecx       ; ecx = ecx - 1 = n-1
         call fibo     ; eax = fibo(n-1)
         mov ebx, eax
         dec ecx
         call fibo     ; eax = fibo(n-1)
         mov ecx, ebx
         add eax, ecx
         ret

; fibo(0) = 1
; fibo(1) = 1
; fibo(n) = fibo(n-1) + fibo(n-2)

%ifdef COMMENT
eax = fibo(ecx)

* fibo(2) =           * fibo(1) = 2
  ecx = ecx - 1 =       ecx = ecx - 1 = 1
  ecx -> stack =        ecx -> stack = 1
  eax = fibo(1) =       eax = fibo(1) = 1
  ecx <- stack =        ecx <- stack = 1
  ecx = ecx - 1 =       ecx = ecx - 1 = 0
  eax -> stack          eax -> stack
  eax = fibo(0) =       eax = fibo(0) = 1
  ecx <- stack =        ecx <- stack = 1
  eax = eax + ecx =     eax = eax + ecx = fibo(0) + fibo(1) = 2
  return eax =          return eax = 1

* fibo(1) =           * fibo(1) = 1
  eax = ecx = 1         eax = ecx = 1
  return eax = 1        return eax = 1
  
* fibo(0) =           * fibo(0) = 1
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
