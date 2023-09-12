cpu 286
org 100h

section .text 
kernel_base equ 0x700
%include "macros.S"

start:
    cli
    xor si, si
    xor di, di
    mov ax, cs
    mov ds, ax
    set_es 0x70
    mov cx, kernel_length
    rep movsb
.pmode:
    lgdt [GDTR]
    mov al, 1
    lmsw ax
    jmp 0x08:.reload_CS
.reload_CS:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov ss, ax
    call clear_screen
    mov si, start_msg
    mov cx, start_msg.len
    call print
    call endline
    mov si, kernel_length
    call print_hex
    call endline
infloop: jmp infloop

%include "screen.S"
%include "memory.S"

section .data
align   8,db 0
GDTR:
dw (GDT.end-GDT-1)
dd (GDT+kernel_base)
align   8,db 0
GDT:
dq 0
.kernel_cs:
dw kernel_length
dw 0x0700
db 0
db 0x9A
dw 0
.kernel_ds:
dw kernel_length
dw 0x0700
db 0
db 0x92
dw 0
.cga_text:
dw 0x0FA0
dw 0x8000
db 0x0B
db 0x92
dw 0
.end:

defstr start_msg, '286'

kernel_end:
kernel_length equ $