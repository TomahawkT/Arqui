SECTION .text
GLOBAL _start
EXTERN print
EXTERN exit
EXTERN numtostr
_start:
    call suma
    push eax
    call numtostr
    mov ebx,esp
    call print
    call exit

suma:
    mov eax,0
    mov ecx,param
.loop:
    cmp ecx,0
    jz .funend
    add eax,ecx
    dec ecx
    jmp .loop

.funend:
    mov ebx, eax
    ret

SECTION .data
param equ 7