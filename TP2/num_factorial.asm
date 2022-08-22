SECTION .text
GLOBAL _start
EXTERN print
EXTERN exit
EXTERN numtostr

_start:
    call fun_factorial
    push eax
    call numtostr
    mov ebx, esp
    call print
    call exit

fun_factorial:
    mov ecx,number
    mov eax,1
.loop:
    cmp ecx,1
    je .funcend
    mul ecx
    dec ecx
    jmp .loop
    
.funcend:
    ret

SECTION .data
number equ 5