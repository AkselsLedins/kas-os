; load dh sectors from drive dl, into es:bx
disk_load:
    pusha
    
    push dx         ; save for later use

    ; from https://en.wikipedia.org/wiki/INT_13H#INT_13h_AH=02h:_Read_Sectors_From_Drive
    
    ; parameters
    ; INT 13h AH=02h: Read Sectors From Drive
    ; AH	02h
    ; AL	Sectors To Read Count
    ; CH	Cylinder
    ; CL	Sector
    ; DH	Head
    ; DL	Drive
    ; ES:BX	Buffer Address Pointer

    ; returns: 
    ; CF	Set On Error, Clear If No Error
    ; AH	Return Code
    ; AL	Actual Sectors Read Count


    mov ah, 0x02        ; ah <- 0x02 is read for int0x13
    ; read parameters
    mov al, dh          ; al <- number of sectors to read, retrieved from 'dh'
    mov cl, 0x02        ; cl <- sector      0x01 is boot sector, 0x02 is available
    mov ch, 0x00        ; ch <- cylinder    0x80 : hdd1 & 0x81 = hdd2
    mov dh, 0x00        ; dh <- head number

    int 0x13            ; bios interrupt
    jc disk_error       ; handle error (stored in carry bit)

    pop dx              ; we retrieve dx
    cmp al, dh          ; should be the same
    jne sectors_error   ; handle the error otherwise

    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call print
    call print_nl
    mov dh, ah          ; return code from read
    call print_hex      ; compare from http://stanislavs.org/helppc/int_13-1.html
    
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR
    call print
    call print_nl

disk_loop:
    jmp $

DISK_ERROR:
    db "Disk read error", 0
SECTORS_ERROR:
    db "Incorrect number of sectors read", 0