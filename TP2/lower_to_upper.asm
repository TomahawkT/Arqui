SECTION .text
GLOBAL _start

_start:
    mov ebx,string
    jmp iterate
    jmp print_text
   
iterate:
    
    mov al,[ebx]
    cmp al,0
    jz print_text
    cmp al,'a'
    jl to_next
    cmp al,'z'
    jg to_next
    sub al,20h
    mov [ebx],al

to_next:
    inc ebx
    jmp iterate

print_text:
    mov eax,4
    mov ebx,1
    mov ecx,string
    mov edx,stringLen
    int 80h
    mov eax,1
    mov ebx,0
    int 80h
SECTION .data
string db "h4ppy c0d1ng", 0
stringLen equ $-string