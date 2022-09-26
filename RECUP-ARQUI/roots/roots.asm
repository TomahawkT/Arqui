GLOBAL _start
EXTERN getRoots
EXTERN exit
EXTERN print

section .text
_start:
    push ebp
    mov ebp, esp

    cmp DWORD[ebp + 4], 4
    jnz .invalid_qty

    mov eax, DWORD[ebp + 12]
    mov ebx, DWORD[ebp + 16]
    mov ecx, DWORD[ebp + 20]
    
    push string
    push ecx
    push ebx
    push eax
    call getRoots

    mov ebx, string
    call print
    mov ebx, nbarra
    call print    
    
.end:
    mov esp, ebp
    pop ebp
    call exit

.invalid_qty:
    mov ebx, err
    call print
    jmp .end

section .rodata
    err db "Invalid qty of arguments", 10, 0
    nbarra db 10, 0

section .bss
    string resb 50