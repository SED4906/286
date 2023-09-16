section .text

clear_bitmap:
multipush ax, cx, di
zero di, ax
not ax
mov cx, 0x8
rep stosb
zero ax
mov cx, 0x78
rep stosb
multipop ax, cx, di
ret

block_allocate: ; count (of 4096 byte blocks) in cx, process in dl, output base in bx
multipush ax, si, di
multipush ax, cx
mov si, (bitmap+8)
.loop:
lodsb
cmp al, 0
jz .zero
cmp si, 128
jge .fail
pop cx
push cx
jmp .loop
.zero:
loop .loop
multipop ax, cx
mov di, si
sub di, cx
mov bx, di
mov al, dl
rep stosb
multipop ax, si, di
ret
.fail:
mov si, oom_msg
mov cx, oom_msg.len
call print
jmp infloop

deallocate_process: ; process in dl
multipush ax, si, di
mov si, (bitmap+8)
mov cx, 120
.loop:
lodsb
cmp al, dl
jne .keep
zero al
mov di, si
dec di
stosb
.keep:
loop .loop
multipop ax, si, di
ret

section .data

defstr oom_msg, 'Out of memory'

conventional_memory_top equ 0x7FFFF
bitmap equ 0
