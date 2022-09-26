GLOBAL pedir_direcc_func
SECTION .text
pedir_direcc_func:
    push ebp
    mov ebp,esp
    add esp,8
    mov eax,esp
    mov esp,ebp
    pop ebp
    ret
    
