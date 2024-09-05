OUTPUT_ARCH(riscv)
ENTRY(_start)
BASE_ADDRESS = 0x80200000; /* kernel初始位置 */

SECTIONS
{
    . = BASE_ADDRESS;
    skernel = .; /* 标记kernel初始位置 */

    stext = .; /* 标记 .text section 初始位置 */
    .text : {
        *(.text.entry) /* 先放入 所有文件 text段 的 entry代码 */
        *(.text .text.*)
    }

    . = ALIGN(4K);
    etext = .; /* 标记text段end的位置 */
    srodata = .; /* 标记rodata段开始的位置 */
    .rodata : {
        *(.rodata .rodata.*)
        *(.srodata .srodata.*)
    }

    . = ALIGN(4K);
    erodata = .;
    sdata = .;
    .data : {
        *(.data .data.*)
        *(.sdata .sdata.*)
    }

    . = ALIGN(4K);
    edata = .;
    .bss : {
        *(.bss.stack) /* 先放 statck */
        sbss = .;
        *(.bss .bss.*)
        *(.sbss .sbss.*)
    }

    . = ALIGN(4K);
    ebss = .;
    ekernel = .;

    /DISCARD/ : {
        *(.eh_frame)
    }
}