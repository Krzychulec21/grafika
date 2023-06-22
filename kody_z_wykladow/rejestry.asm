         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         xor eax, eax  ; eax = eax ^ eax = 0
         xor ecx, ecx  ; ecx = ecx ^ ecx = 0
         xor edx, edx  ; edx = edx ^ edx = 0

;                 __  __    ax
;        [00][00][00][00]  eax
;                 ah  al

         mov al, 78h  ; al = 78h
         mov ah, 56h  ; ah = 56h

;                 __  __    ax
;        [00][00][56][78]  eax
;                 ah  al

         mov cx, 5678h  ; cx = 5678h

;                 __  __    cx
;        [00][00][56][78]  ecx
;                 ch  cl

         mov edx, 12345678h  ; edx = 12345678h

;                 __  __    dx
;        [12][34][56][78]  edx
;                 dh  dl

         push edx
         push ecx
         push eax

;        esp -> [eax][ecx][edx][ret]

         call getaddr
format:
         db "eax = %08x", 0xA
         db "ecx = %08x", 0xA
         db "edx = %08x", 0xA, 0
getaddr:

;        esp -> [format][eax][ecx][edx][ret]

         call [ebx+3*4]  ; printf(format, eax, ecx, edx);
         add esp, 4*4    ; esp = esp + 16

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