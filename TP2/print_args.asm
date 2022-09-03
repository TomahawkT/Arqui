SECTION .text
GLOBAL _start
EXTERN print
EXTERN exit

_start:
    mov ebp,esp
    call print_args
    mov esp,ebp
    call exit
print_args:
    mov eax,ebp
    add eax,8
    mov edx,[ebp]
    sub edx,1
    mov ecx,0
.loop:
    cmp ecx,edx
    je .funcend
    mov ebx,[eax]
    call print
    mov ebx,espacio
    call print
    add eax,4
    inc ecx
    jmp .loop
.funcend:
    ret
SECTION .data
espacio db ' '