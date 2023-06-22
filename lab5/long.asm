         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

a        equ -9223372036854775808

%define  LLONG_MIN -9223372036854775808
%define  LLONG_MAX  9223372036854775807

%define  UINT_MAX 4294967295

a_l      equ a % (UINT_MAX + 1)
a_h      equ a / (UINT_MAX + 1)

         mov eax, a_l  ; eax = a_l
         mov edx, a_h  ; edx = a_h

;        edx:eax = a

         push edx
         push eax

;        esp -> [a_l][a_h][ret]

         call getaddr
format:
         db "long long value = %lld", 0xA, 0
getaddr:

;        esp -> [format][a_l][a_h][ret]

         call [ebx+3*4]  ; printf(format, a);
         add esp, 3*4    ; esp = esp + 12

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