SECTION .text
GLOBAL _start
EXTERN  numtostr
EXTERN print
EXTERN exit

_start:
    mov ebp,esp
    mov eax,[ebp]
    push eax
    call numtostr
    mov ebx,esp
    call print
    call exit
