         [bits 64]

;        rsp -> [ret]


;          0:rax
;        + 0:rsi
;        -------
;        rdi:rsi

a        equ 4294967295
b        equ 2

         mov rax, a  ; rax = a
         mov rsi, b  ; rsi = b

         add rsi, rax  ; rsi += rax

         mov rdi, 0  ; rdi = 0
         adc rdi, 0  ; rdi += 0 + CF

         push rdi  ; rdi -> stack
         push rsi  ; rsi -> stack

;        esp -> [format][rsi][rdi][ret]

         call getaddr

format:
         db "suma = %lli", 0xA, 0

getaddr:

;        rsp -> [format][rsi][rdi][ret]

         call [rbx+3*4]  ; printf(format, edi:esi)
         add rsp, 3*4    ; rsp += 12

;        rsp -> [ret]

         push 0

;        rsp -> [0][ret]

         call [rbx+0*4]  ; exit(0)