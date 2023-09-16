%macro  multipush 1-* 
%rep  %0 
    push %1 
    %rotate 1 
%endrep 
%endmacro

%macro  multipop 1-* 
%rep  %0 
    %rotate -1
    pop %1 
%endrep 
%endmacro

%macro outb 2
mov dx, %1
mov al, %2
out dx, al
%endmacro

%macro set_segs 1
mov ax, %1
mov ds, ax
mov es, ax
mov ss, ax
%endmacro

%macro set_ds 1
mov ax, %1
mov ds, ax
%endmacro

%macro set_es 1
mov ax, %1
mov es, ax
%endmacro

%macro defstr 2
%1: db %2
.len equ $-%1
%endmacro

%macro zero 1-*
%rep  %0 
    %rotate 1
    xor %1, %1
%endrep 
%endmacro

%macro nybble 2
%if %2
shr %1, (%2*4)
%endif
and %1, 0x0F
%endmacro

%macro print_hex_fragment 1
    mov ax, si
    nybble ax, %1
    call to_hex_digit
    stosb
    mov al, [text_color]
    stosb
%endmacro

%macro isr_no_err 1
isr%1:
    push %1
    push 0
    jmp interrupt_handler
%endmacro

%macro isr_err 1
isr%1:
    push %1
    jmp interrupt_handler
%endmacro

%macro interrupt_gate 1
dw %1
dw 8
db 0
db 0x86
dw 0
%endmacro

%macro trap_gate 1
dw %1
dw 8
db 0
db 0x87
dw 0
%endmacro