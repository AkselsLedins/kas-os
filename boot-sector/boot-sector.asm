; Often loaded into 0x7c00
[org 0x7c00]                    ; set the offset to bootsector code

mov bx, WELCOME
call print
call print_nl


mov bx, GOODBYE
call print

call print_nl

mov dx, 0x1234
call print_hex

; Infinite loop (e9 fd ff)
jmp $

%include "./boot-sector-helpers.asm"

; data
WELCOME:
    db 'Welcome on KAS-OS', 0

GOODBYE:
    db 'Goodbye!', 0

; fill with 510 zeros minus the size of the previous code (padding)
; and add magic numbetr
times 510-($-$$) db 0
dw 0xaa55 