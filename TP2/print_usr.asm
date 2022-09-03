SECTION .text
GLOBAL _start
EXTERN print
EXTERN exit
EXTERN numtostr
_start:
    mov ebp,esp
    call findVarsEntorno
    ;call findUSER
    mov esp,ebp
    call exit
findVarsEntorno:
    mov eax,ebp
    add eax,8
.loop:
    cmp eax,0
    je .found
    add eax,4
    jmp .loop
.found:
    add eax,8
    push eax
    call numtostr
    mov ebx,esp
    call print
    ret
findUSER:
.loop:
    call checkUSER
    cmp ebx,0
    je .increase
.increase:
    add eax,4
    jmp .loop
checkUSER:
    mov edx,string
    mov ecx,0
.loop:
    ;cmp [eax]+ecx,[ebx]
    ;jne .nextDir
    cmp ecx,stringLen
    je .found
    inc ecx
    jmp .loop
.nextDir:
    add eax,4
    mov ecx,0
    jmp .loop
.found:
    ;mov eax,[eax]+5
    ret
    
SECTION .data
string db 'USER='
stringLen equ $-string