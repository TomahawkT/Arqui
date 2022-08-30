GLOBAL main
EXTERN printf

SECTION .rodata
fmt db "Cantidad de argumentos: %d\n", 0
SECTION .text
main:
    push ebp   ;Armado de stack frame
    mov ebp,esp;

    push dword [ebp+8]
    push fmt
    call printf
    add esp, 2*4
    mov ecx,[ebp+8]
.loop:
    cmp 
    call print_args

    mov eax,0
    mov esp,ebp; Desarmado de stack frame
    pop ebp
    ret