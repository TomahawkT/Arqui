GLOBAL print
GLOBAL exit
GLOBAL numtos
GLOBAL sumn
section .text

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
; exit - termina el programa
;-----------------------------------------------------------
; Argumentos:
;    ebx: valor de retorno al sistema operativo
;-----------------------------------------------------------
exit:
    mov eax, 1        ; ID del Syscall EXIT
    int 80h            ; Ejecucion de la llamada


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

;------------------------------------------------------
;        EN ZONA DE MEMORIA PASA NUM A STRING
;Arg:
;   - ebx zona de memoria
;   - eax numero a transformar
;-------------------------------------------------------

numtos:
    pushad
    pushf
    
    mov esi, ebx
    mov ebx, 0
    mov ecx, 10

.loop:
    mov edx, 0
    div ecx
    add edx, 48
    mov [buffer + ebx], dl
    inc ebx

    cmp eax, 0
    jnz .loop

.reverseLoop:
    dec ebx
    mov cl, [buffer + ebx]
    mov [esi], cl
    inc esi
    cmp ebx, 0
    jz .fin
    jmp .reverseLoop

.fin:
    mov BYTE [esi], 0
    popf
    popad
    ret


;---------------------------------------------
;                    SUMN
;Argumentos:
;   - eax el num
;---------------------------------------------
sumn:  
    push ecx
    mov ecx, 0
.loop:
    add ecx, eax
    dec eax
    cmp eax, 0
    jne .loop
.fin:
    mov eax, ecx
    pop ecx
    ret

section .bss    
    buffer resb 128