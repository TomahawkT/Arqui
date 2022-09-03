SECTION .text
GLOBAL _start
EXTERN print
EXTERN exit
EXTERN numtostr

_start:
    mov eax,0x14
    int 80h
    push eax
    call numtostr
    mov ebx,esp
    call print
    call exit