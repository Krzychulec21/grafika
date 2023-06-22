%ifdef COMMENT
suma(n) = 0 + 1 + 2 + ... + n

suma(0) = 0
suma(n) = n + suma(n-1)

suma(0) = 0
suma(1) = 1
suma(2) = 3
suma(3) = 6
suma(4) = 10
suma(5) = 15
%endif

         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

n        equ 5

         mov ecx, n  ; ecx = n
         
         call silnia  ; eax = silnia(ecx)  ; fastcall
         
addr:
         push eax
         
         call getaddr
format:  
         db"silnia = %d", 0xA, 0
getaddr:

        call [ebx + 3*4]
        add esp, 8
        
        push 0
        call [ebx + 0*4]
        
silnia:
       cmp ecx, 0
       jne rec
       mov eax, 1
       ret
       
rec:   push ecx
       dec ecx
       call silnia
       pop ecx
       mul ecx
       ret

; suma(0) = 0
; suma(n) = n + suma(n-1)

%ifdef COMMENT
eax = suma(ecx)

* suma(1) =           * suma(1) = 1
  ecx -> stack = 1      ecx -> stack = 1
  ecx = ecx - 1 = 0     ecx = ecx - 1 = 0
  eax = suma(0) =       eax = suma(0) = 0
  ecx <- stack = 1      ecx <- stack = 1
  eax = eax + ecx =     eax = eax + ecx = 0 + 1 = 1
  return eax =          return eax = 1

* suma(0) =           * suma(0) = 0
  eax = ecx = 0         eax = ecx = 0
  return eax = 0        return eax = 0
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
