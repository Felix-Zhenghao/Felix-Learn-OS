#![no_std]
#![no_main]
#![feature(panic_info_message)]

mod lang_items;
mod sbi;
#[macro_use]
mod console;

use core::arch::global_asm;
global_asm!(include_str!("entry.asm"));

// here from entry.asm, rust code will be called
#[no_mangle]
pub fn rust_main() -> ! {
    clear_bss();
    println!("Hello, world!");
    panic!("Shutdown machine!");
}

// initialize BSS segment to all zero (see linker.ld for definition of sbbs and ebss)
fn clear_bss() {
    extern "C" {
        fn sbss();
        fn ebss();
    }
    (sbss as usize..ebss as usize).for_each(|addr| {
        unsafe {
            (addr as *mut u8).write_volatile(0);
        }
    });
}
