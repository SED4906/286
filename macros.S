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