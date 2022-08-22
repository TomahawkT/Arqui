SECTION .text
GLOBAL _start
EXTERN print
EXTERN exit
EXTERN numtostr

_start:
    call getMultiples
    call exit

getMultiples:
    mov ecx,1
.loop:
    mov eax,number
    cmp ecx,limit
    jg .funend
    mul ecx
    push eax
    call numtostr
    mov ebx,esp
    call print
    inc ecx
    jmp .loop

.funend:
    mov ebx,0
    ret
SECTION .data
number equ 4
limit equ 5