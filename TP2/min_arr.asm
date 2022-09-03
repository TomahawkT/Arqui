SECTION .text
GLOBAL _start
EXTERN numtostr
EXTERN print
EXTERN exit

_start:
    call findMin
    push eax
    call numtostr
    mov ebx,esp
    call print
    call exit

findMin:
    mov eax,[numArray]
    mov ecx,0
    mov edx,0
.loop:
    cmp edx,numArrayLen
    je .end
    cmp eax,[numArray+ecx]
    jg .swap
.next:
    add ecx,4
    add edx,4
    jmp .loop

.swap:
    mov eax,[numArray+ecx]
    jmp .next
.end:
    ret
SECTION .data
numArray dd 5,7,4,1,1,9,8
numArrayLen equ $-numArray