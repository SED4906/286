cpu 286
org 100h

section .text 
kernel_base equ 0x700
%include "macros.S"

start:
    cli
    zero si, di
    set_ds cs
    set_es 0x70
    mov cx, kernel_length
    rep movsb
.pmode:
    lgdt [GDTR]
    mov al, 1
    lmsw ax
    jmp 0x08:.reload_CS
.reload_CS:
    set_segs 0x10
    call clear_screen
    lidt [IDTR]
    mov si, start_msg
    mov cx, start_msg.len
    call print
    call endline
    mov si, kernel_size_msg
    mov cx, kernel_size_msg.len
    call print
    mov si, kernel_length
    call print_hex
    call endline
    call clear_bitmap
infloop: jmp infloop

%include "interrupts.S"
%include "screen.S"
%include "memory.S"
%include "switch.S"

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
.user_cs:
dw 0
dw 0
db 0
db 0xFA
dw 0
.user_ds:
dw 0
dw 0
db 0
db 0xF2
dw 0
.temp_es:
dw 0
dw 0
db 0
db 0x92
dw 0
.end:

defstr start_msg, '286'
defstr kernel_size_msg, 'Kernel size: '

kernel_end:
kernel_length equ $