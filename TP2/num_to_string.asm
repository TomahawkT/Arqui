SECTION .text
GLOBAL _start

_start:
    mov eax, number
    call numTester
    mov eax,1
    mov ebx,0
    int 80h

numTester:
    push dword 0
    mov ebx,10
    mov ecx,0
.loop:
    cmp eax,0
    jz stackToString
    mov edx,0
    div ebx
    add edx,30h
    push edx
    jmp .loop

 
stackToString:
    pop eax
    mov [memoryAddress+ecx],eax
    cmp eax,0
    jz .funcend
    inc cx
    jmp stackToString
.funcend:
    ret

SECTION .data
number equ 246
SECTION .bss
memoryAddress resb 10
