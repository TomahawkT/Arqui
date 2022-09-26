GLOBAL _start
GLOBAL sys_write
EXTERN print
EXTERN getAverage

section .text
_start:
    push ebp
    mov ebp, esp

    lea eax, [ebp + 8]      ;char * argv[]
    mov ebx, [ebp + 4]      ;int argc

    push eax
    push ebx
    call getAverage

    mov esp, ebp
    pop ebp
    call exit

exit:
    mov eax, 1        ; ID del Syscall EXIT
    int 80h            ; Ejecucion de la llamad

;-----------------------------------------------------------
; sys_write - escribe a fd los primeros count bytes de buff
;-----------------------------------------------------------
; Argumentos:
;   int fd
;   const void * buffer
;   size_t count/length
; Returns:
;   ssize_t number of bytes written
;   -1 means there was an error
;-----------------------------------------------------------
global sys_write
sys_write:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, 4
    mov ebx, [ebp + 8] ; fd
    mov ecx, [ebp + 12] ; buffer
    mov edx, [ebp + 16] ; count/length
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret

section .bss
    buffer resb 15

section .rodata
    err db "Invalid qty of args", 10, 0
    nbarra db 10, 0