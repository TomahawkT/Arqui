section .text
GLOBAL _start
EXTERN print
EXTERN exit
EXTERN numtostr

_start:
    call bsort
    call printarr
    call exit

bsort: 
    push ebp
    mov ebp, esp ;guardo el puntero del stack
    pushad
.inici    mov edx,0  ;cuento los swaps
    mov esi,0
    mov ecx,arr
    mov eax,[ecx]
    add esi,4
    add ecx,4
    mov ebx, [ecx];
    add esi,4

.comp    cmp eax,ebx
    jg .swap

.sig cmp esi,tam
    je .check
    mov eax,[ecx]
    add ecx,4
    add esi,4 
    mov ebx,[ecx]
    jmp .comp

.check cmp edx,0
    jne .inici
    popad
    mov esp, ebp
	pop ebp
    ret

.swap  mov [ecx], eax
    mov [ecx-4],ebx
    inc edx 
    jmp .sig

printarr:
    push ebp
    mov ebp, esp ;guardo el puntero del stack
    mov ecx,arr
    mov esi,0
.lop   mov eax,[ecx]
    push eax
    call numtostr
    mov ebx,esp
    call print
    cmp esi,tam
    je .end
    add ecx,4
    add esi,4
    jmp .lop
.end mov esp, ebp
	pop ebp
    ret



section .data
    arr dd 5,2,8,9,1,7,6,4,5
    tam equ $-arr
