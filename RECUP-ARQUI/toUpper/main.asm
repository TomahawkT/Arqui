GLOBAL _start
GLOBAL sys_read
EXTERN toUpper

section .text
_start:
    push ebp
    mov ebp, esp

    mov eax, 128
    mov ebx, buffer
    mov ecx, 0

    push eax
    push ebx
    push ecx
    call sys_read

    push ebx
    call toUpper

    call print
    mov esp, ebp
    pop ebp
    call exit

;-----------------------------------------------------------
; print - imprimer una cadena en la salida estandar
;-----------------------------------------------------------
; Argumentos:
;    ebx: cadena a imprimer en pantalla, terminada con 0
;-----------------------------------------------------------
print:
    pushad        ; hago backup de los registros

    call strlen
    mov ecx, ebx    ; la cadena esta en ebx
    mov edx, eax    ; en eax viene el largo de la cadena

    mov ebx, 1        ; FileDescriptor (STDOUT)
    mov eax, 4        ; ID del Syscall WRITE
    int 80h
    
    popad         ; restauro los registros
    ret    

;-----------------------------------------------------------
; strlen - calcula la longitud de una cadena terminada con 0
;-----------------------------------------------------------
; Argumentos:
;    ebx: puntero a la cadena
; Retorno:
;    eax: largo de la cadena
;-----------------------------------------------------------
strlen:
    push ecx ; preservo ecx    
    push ebx ; preservo ebx
    pushf    ; preservo los flags

    mov ecx, 0    ; inicializo el contador en 0
.loop:            ; etiqueta local a strlen
    mov al, [ebx]     ; traigo al registo AL el valor apuntado por ebx
    cmp al, 0    ; lo comparo con 0 o NULL
    jz .fin     ; Si es cero, termino.
    inc ecx        ; Incremento el contador
    inc ebx
    jmp .loop
.fin:                ; etiqueta local a strlen
    mov eax, ecx    
    popf
    pop ebx ; restauro ebx    
    pop ecx ; restauro ecx
    ret


;-----------------------------------------------------------
; exit - termina el programa
;-----------------------------------------------------------
; Argumentos:
;    ebx: valor de retorno al sistema operativo
;-----------------------------------------------------------
exit:
    mov eax, 1        ; ID del Syscall EXIT
    int 80h            ; Ejecucion de la llamada



;-----------------------------------------------------------
; sys_read - guarda en buff los primeros count bytes de fd
;-----------------------------------------------------------
; Argumentos:
;   int fd
;   (void *) buffer
;   size_t count/length
; Returns:
;   size_t number of bytes read
;   0 means EOF was reached
;-----------------------------------------------------------
sys_read:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, 3
    mov ebx, [ebp + 8] ; fd
    mov ecx, [ebp + 12] ; buffer
    mov edx, [ebp + 16] ; count/length
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret


section .rodata
    nbarra db 10, 0

section .bss    
    buffer resb 128