; Often loaded into 0x7c00
[org 0x7c00]                    ; set the offset to bootsector code

mov bx, WELCOME
call print
call print_nl

mov bp, 0x8000 ; set the stack far from us
mov sp, bp

mov bx, 0x9000
mov dh, 2       ; read 2 sectors

call disk_load

; Infinite loop (e9 fd ff)
jmp $

%include "./boot-sector-helpers.asm"
%include "./boot-sector-disk.asm"

; data
WELCOME:
    db 'Welcome on KAS-OS', 0

GOODBYE:
    db 'Goodbye!', 0


; magic number
times 510-($-$$) db 0
dw 0xaa55 

times 256 dw 0xdada ; sector 2 = 512 bytes
times 256 dw 0xface ; sector 3 = 512 bytes