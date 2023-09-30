print_string: ; si, cx
multipush ax, di, es
    mov es, 0x18
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

endline:
multipush ax, cx, dx
    mov ax, [screen_offset]
    zero dx
    mov cx, 160
    idiv cx
    sub [screen_offset], dx
    add [screen_offset], cx
multipop ax, cx, dx
jmp cursor_reposition

print_hex: ; si
multipush ax, di, es
    mov es, 0x18
    mov di, [screen_offset]
    print_hex_fragment 3
    print_hex_fragment 2
    print_hex_fragment 1
    print_hex_fragment 0
    mov [screen_offset], di
multipop ax, di, es
jmp cursor_reposition

to_hex_digit:
    add ax, '0'
    cmp ax, '9'
    jle .finish
    add ax, 7
.finish:
ret

clear_screen:
multipush ax, di, es
    mov es, 0x18
    zero di
    mov ax, 0x0720
    mov cx, 2000
    rep stosw
    mov word [screen_offset], 0
multipop ax, di, es
jmp cursor_reposition


screen_offset: dw 0
text_color: db 0x07