section .text
GLOBAL _start

_start:
    mov rax,1;
    mov rdi, 0;
    mov rsi, string;
    mov rdx, stringLen;
    Syscall

    mov rax,60;
    Syscall

section .data
string db "Hello World", 10
stringLen equ $-string
