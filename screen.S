clear_screen:
multipush ax, di, cx, es
    set_es 0x18
    mov ax, 0x0720
    xor di, di
    mov [screen_offset], di
    mov cx, (80*25)
    rep stosw
multipop ax, di, cx, es
jmp cursor_reposition

print:
multipush ax, di, es
    set_es 0x18
    mov di, [screen_offset]
    .loop:
        movsb
        mov al, [text_color]
        stosb
    loop .loop
    mov [screen_offset], di
multipop ax, di, es
jmp cursor_reposition

cursor_reposition:
multipush ax, bx, dx
    mov bx, [screen_offset]
    shr bx, 1
    outb 0x3D4, 0x0F
    outb 0x3D5, bl
    outb 0x3D4, 0x0E
    outb 0x3D5, bh
multipop ax, bx, dx
ret