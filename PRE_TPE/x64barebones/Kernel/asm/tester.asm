GLOBAL testASM:
SECTION .text
    
testASM:
    push rbp
    mov rbp, rsp

    mov rcx,rdx
    mov rdx,rsi
    mov rsi,rdi
    mov rdi,1
    int 80h

    mov rsp,rbp
    pop rbp
    ret