         [bits 32]

;        esp -> [ret]  ; ret - adres powrotu do asmloader

         mov eax, 12345678h  ; eax = 12345678h

;                 __  __    ax
;        [12][34][56][78]  eax
;                 ah  al

         movzx ecx, al  ; ecx = 0:al = 78h

;                 __  __    cx
;        [00][00][00][78]  ecx
;                 ch  cl

         movzx edx, ah  ; edx = 0:ah = 56h

;                 __  __    dx
;        [00][00][00][56]  edx
;                 dh  dl

         movzx ebp, ax  ; ebp = ax = 5678h

;                 __  __    bp
;        [00][00][56][78]  ebp
;                     bpl

         push ebp
         push edx
         push ecx
         push eax

;        esp -> [eax][ecx][edx][ebp][ret]

         call getaddr
format:
         db "eax = %08x", 0xA
         db "ecx = %08x", 0xA
         db "edx = %08x", 0xA
         db "ebp = %08x", 0xA, 0
getaddr:

;        esp -> [format][eax][ecx][edx][ebp][ret]

         call [ebx+3*4]  ; printf(format, eax, ecx, edx, ebp);
         add esp, 5*4    ; esp = esp + 20

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

;        [00][00][00][00]  eax
;        [00][00][00][00]  ecx
;        [00][00][00][00]  edx

;                     __   al
;        [00][00][00][00]
;                 __       ah
;        [00][00][00][00]
;                 __  __   ax
;        [00][00][00][00]
;         __  __  __  __   eax
;        [00][00][00][00]