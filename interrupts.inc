interrupt_handler:
pusha
mov bp, sp
add bp, 16
mov bx, [bp]
mov ax, [bp+2]
mov si, [error_msg_ptr_table+eax*2]
mov cx, [error_msg_len_table+eax*2]
call print_string
call word [handler_table+ebx*2]
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
jmp die

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
divide_error_msg defstr "Divide error"
single_step_msg defstr "%"
nmi_msg defstr "NMI"
breakpoint_msg defstr "!"
into_overflow_msg defstr "INTO overflow"
bound_range_msg defstr "Bound range exceeded"
invalid_opcode_msg defstr "Invalid opcode"
coprocessor_missing_msg defstr "Coprocessor missing"
double_fault_msg defstr "Double fault"
coprocessor_segment_overrun_msg defstr "Coprocessor segment overrun"
invalid_tss_msg defstr "Invalid TSS"
missing_segment_msg defstr "Missing segment"
stack_segment_msg defstr "Stack segment error"
segment_overrun_msg defstr "Segment overrun"
eek14_msg defstr "#14 (??)"
eek15_msg defstr "#15 (??)"
coprocessor_error_msg defstr "Coprocessor error"

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
dw divide_error_msg.size
dw single_step_msg.size
dw nmi_msg.size
dw breakpoint_msg.size
dw into_overflow_msg.size
dw bound_range_msg.size
dw invalid_opcode_msg.size
dw coprocessor_missing_msg.size
dw double_fault_msg.size
dw coprocessor_segment_overrun_msg.size
dw invalid_tss_msg.size
dw missing_segment_msg.size
dw stack_segment_msg.size
dw segment_overrun_msg.size
dw eek14_msg.size
dw eek15_msg.size
dw coprocessor_error_msg.size

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