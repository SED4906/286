section .text

interrupt_handler:
pusha
mov bp, sp
add bp, 16
mov bx, [bp]
mov ax, [bp+2]
mov si, [error_msg_ptr_table+eax*2]
mov cx, [error_msg_len_table+eax*2]
call print
call [handler_table+ebx*2]
popa
add sp, 4
iret

eek: ; invalid interrupt, eek
divide_error:
single_step:
nmi:
breakpoint:
into_overflow:
bound_range:
invalid_opcode:
coprocessor_missing:
double_fault:
coprocessor_segment_overrun:
invalid_tss:
missing_segment:
stack_segment:
segment_overrun:
coprocessor_error:
jmp infloop

section .data

handler_table:
dw divide_error, single_step, nmi, breakpoint
dw into_overflow, bound_range, invalid_opcode, coprocessor_missing
dw double_fault, coprocessor_segment_overrun, invalid_tss, missing_segment
dw stack_segment, segment_overrun, eek, eek
dw coprocessor_error, eek, eek, eek
dw eek, eek, eek, eek
dw eek, eek, eek, eek
dw eek, eek, eek, eek

error_msg_table:
defstr divide_error_msg, "Divide error"
defstr single_step_msg, "%"
defstr nmi_msg, "NMI"
defstr breakpoint_msg, "!"
defstr into_overflow_msg, "INTO overflow"
defstr bound_range_msg, "Bound range exceeded"
defstr invalid_opcode_msg, "Invalid opcode"
defstr coprocessor_missing_msg, "Coprocessor missing"
defstr double_fault_msg, "Double fault"
defstr coprocessor_segment_overrun_msg, "Coprocessor segment overrun"
defstr invalid_tss_msg, "Invalid TSS"
defstr missing_segment_msg, "Missing segment"
defstr stack_segment_msg, "Stack segment error"
defstr segment_overrun_msg, "Segment overrun"
defstr eek14_msg, "#14 (??)"
defstr eek15_msg, "#15 (??)"
defstr coprocessor_error_msg, "Coprocessor error"

error_msg_ptr_table:
dw divide_error_msg
dw single_step_msg
dw nmi_msg
dw breakpoint_msg
dw into_overflow_msg
dw bound_range_msg
dw invalid_opcode_msg
dw coprocessor_missing_msg
dw double_fault_msg
dw coprocessor_segment_overrun_msg
dw invalid_tss_msg
dw missing_segment_msg
dw stack_segment_msg
dw segment_overrun_msg
dw eek14_msg
dw eek15_msg
dw coprocessor_error_msg

error_msg_len_table:
dw divide_error_msg.len
dw single_step_msg.len
dw nmi_msg.len
dw breakpoint_msg.len
dw into_overflow_msg.len
dw bound_range_msg.len
dw invalid_opcode_msg.len
dw coprocessor_missing_msg.len
dw double_fault_msg.len
dw coprocessor_segment_overrun_msg.len
dw invalid_tss_msg.len
dw missing_segment_msg.len
dw stack_segment_msg.len
dw segment_overrun_msg.len
dw eek14_msg.len
dw eek15_msg.len
dw coprocessor_error_msg.len

IDTR:
dw (17*8-1)
dd (IDT+kernel_base)

IDT:
trap_gate isr0
trap_gate isr1
interrupt_gate isr2
trap_gate isr3
trap_gate isr4
trap_gate isr5
trap_gate isr6
interrupt_gate isr7
trap_gate isr8
interrupt_gate isr9
trap_gate isr10
trap_gate isr11
trap_gate isr12
trap_gate isr13
trap_gate isr14
trap_gate isr15
interrupt_gate isr16

isr_no_err 0
isr_no_err 1
isr_no_err 2
isr_no_err 3
isr_no_err 4
isr_no_err 5
isr_no_err 6
isr_no_err 7
isr_err 8
isr_no_err 9
isr_err 10
isr_err 11
isr_err 12
isr_err 13
isr_no_err 14
isr_no_err 15
isr_no_err 16
%assign i 17
%rep 15
isr_no_err i
%assign i i+1
%endrep