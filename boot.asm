use16
org 0x100
kernel_base = 0x700
include 'macros.inc'

start:
    cli
    zero si, di
    mov ds, cs
    mov es, 0x70
    mov cx, kernel_length
    rep movsb
.pmode:
    lgdt [GDTR]
    mov al, 1
    lmsw ax
    jmp 0x08:.reload_CS
    .reload_CS:
    set_segs 0x10
    lidt [IDTR]
    call clear_screen
    ;call set_mode_x ; not yet
    println start_msg
    println kernel_size_msg, kernel_length
    .wait: hlt
    jmp .wait
die:
cli
hlt
jmp die ; die of death

start_msg defstr "286"
kernel_size_msg defstr "Kernel size: "

include "screen.inc"
include "interrupts.inc"
;include "vga.inc"

align   8
GDTR:
dw (GDT.end-GDT-1)
dd (GDT+kernel_base)
align   8
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
.cga_es:
dw 4000
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

kernel_length = $