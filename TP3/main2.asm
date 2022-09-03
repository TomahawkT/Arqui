GLOBAL main
EXTERN puts, sprintf
SECTION .rodata
fmt db "%d", 0
number dd 123456790

SECTION .text
main:
    push dword [number]
    push fmt
    push buffer

    call sprintf

    add esp, 3*4
    push buffer
    call puts

    add esp,4
    ret

SECTION .bss
buffer resb 40