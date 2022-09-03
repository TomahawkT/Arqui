SECTION .text
GLOBAL _start
EXTERN main
_start:
    mov eax,[esp]
    dec eax
    push eax
    push [esp+8]
    call main
    mov ebx,eax
    mov eax,1
    int 80h