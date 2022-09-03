GLOBAL main
EXTERN printf

section .rodata
fmt db "Cantidad de argumentos: %d", 10, 0
arg db "Argumento: %s", 10, 0

section .text
main:
    push ebp ; Armado de stack frame
    mov ebp, esp ;

    mov edi, [ebp + 8]; Contador en edi
    push dword [ebp + 8]
    push fmt
    call printf
    add esp, 24

    mov eax, [ebp + 12]; EAX ahora apunta al primer elemento del vector de argumentos.

.loop:
    add eax, 4
    sub edi, 1
    push eax
    push dword [eax]
    push arg
    call printf
    add esp, 16
    pop eax
    cmp edi, 1
    je .end
    jmp .loop

.end:
    mov eax, 0

    mov esp, ebp ; Desarmado de stack frame
    pop ebp
    ret
