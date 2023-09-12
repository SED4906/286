cpu 286
org 100h
BINSIZE equ (kernel_end-start+100h)

section .text 

start:
    cli
    mov ax, cs
    mov bx, cs
    shl ax, 4
    shr bx, 12
    mov [GDT.kernel_cs+2], ax
    mov [GDT.kernel_cs+4], bl
    mov [GDT.kernel_ds+2], ax
    mov [GDT.kernel_ds+4], bl
    add [GDTR+2], ax
    add [GDTR+4], bl
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
infloop: jmp infloop

%include "macros.S"
%include "screen.S"

section .data
align   8,db 0
GDTR:
dw (GDT.end-GDT-1)
dd GDT
align   8,db 0
GDT:
dq 0
.kernel_cs:
dw BINSIZE
dw 0
db 0
db 0x9A
dw 0
.kernel_ds:
dw BINSIZE
dw 0
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

screen_offset: dw 0
text_color: db 0x07
defstr start_msg, '286'

section .bss

kernel_end: