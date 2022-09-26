
GLOBAL main
EXTERN printf
SECTION .text


main:
    push ebp
    mov ebp,esp
    mov eax,0
    cpuid
    push eax
    push ecx
    push edx
    push ebx
    push esp
    push fmt
    call printf
    mov eax,0
    mov esp,ebp
    pop ebp
    ret
    


SECTION .data
fmt db "Fabricante: %s",10,0