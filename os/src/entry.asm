    .section .text.entry
    .globl _start
_start:
    la sp, boot_stack_top
    call rust_main

    .section .bss.stack
    .globl boot_stack_lower_bound

boot_stack_lower_bound: # 栈能够增长到的下限位置
    .space 4096*16 # 预留一段64KiB的空间作为要运行程序的栈空间
    .globl boot_stack_top
    
boot_stack_top: