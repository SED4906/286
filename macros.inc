macro zero [arg] { forward xor arg,arg }

macro multipush [arg] { forward push arg }
macro multipop [arg] { reverse pop arg }

macro mov op1,op2 {
    if op1 in <ds,es,fs,gs,ss> & ~ op2 in <ax,bx,cx,dx,si,di,bp,sp>
        push  op2
        pop   op1
    else
        mov   op1,op2
    end if
}

macro set_segs seg {
    mov ax,seg
    mov ds,ax
    mov es,ax
    mov ss,ax
}

struc defstr [data]
{
    common
        . db data
        .size = $ - .
}

macro outb prt,byt {
    mov dx, prt
    mov al, byt
    out dx, al
}

macro inb prt {
    mov dx, prt
    in al, dx
}

macro nybble arg, which {
    if which
    shr arg, (which*4)
    end if
    and arg, 0x0F
}


macro print_hex_fragment which {
    mov ax, si
    nybble ax, which
    call to_hex_digit
    stosb
    mov al, [text_color]
    stosb
}

macro print [arg] {
    forward
        mov si, arg
        if defined arg#.size & arg#.size > 0
            mov cx, arg#.size
            call print_string
        else
            call print_hex
        end if
}

macro println [arg] {
    print arg
    common call endline
}

macro trap_gate arg {
dw arg
dw 8
db 0
db 0x87
dw 0
}

macro interrupt_gate arg {
dw arg
dw 8
db 0
db 0x86
dw 0
}

macro isr_no_err i {
isr#i:
    push 0
    push i
    jmp interrupt_handler
}

macro isr_err i {
isr#i:
    push i
    jmp interrupt_handler
}

macro pic_eoi irq {
if irq > 7
outb 0xA0, 0x20
end if
outb 0x20, 0x20
}