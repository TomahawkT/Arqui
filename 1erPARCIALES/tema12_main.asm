GLOBAL swapper
SECTION .text
swapper:
    push ebp
    mov ebp,esp
    push ebx

    mov eax,4
    mov ebx,[ebp+8]
    mov ecx,[ebp+12]
    mov edx,[ebp+16]
    int 80h
    
    pop ebx
    mov esp,ebp
    pop ebp

    mov eax,1
    int 80h

SECTION .data
filename2 db "DatosB.txt",0
fmt2 db "%s %s %s %s %s",0
SECTION .bss
buffer resb 100