section .text
GLOBAL CheckLong

;---------------------------------------------------
;                    CHECKLONG
; Retorna la dif entre el largo calculado y el dado
;
; Argumentos:
;   - array
;   - size
; Retorna:
;   - en eax la diferencia
;---------------------------------------------------

CheckLong:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, [ebp + 8]     ;array
    mov ecx, [ebp + 12]     ;size
    mov edx, 0              ;counter

    jmp .loop

.add:
    inc eax
    inc edx
.loop:
    cmp [eax], BYTE 0
    jne .add

    mov eax, edx
    sub eax, ecx

    pop ebx
    mov esp, ebp
    pop ebp
    ret

