section .text
GLOBAL exit
GLOBAL read
GLOBAL write
GLOBAL open
GLOBAL close
GLOBAL print


;-----------------------------------------------------------
; print - Imprime argumentos
;-----------------------------------------------------------
; Argumentos:
;    ecx: String a imprmir.
;    edx: Largo del String
;-----------------------------------------------------------print:
    pushad
    mov eax, 4
    mov ebx, 1
    int 80h
    popad
    ret

;-----------------------------------------------------------
; exit - termina el programa
;-----------------------------------------------------------
; Argumentos:
;    ebx: valor de retorno al sistema operativo
;-----------------------------------------------------------
exit:
    ENTER 0,0
    push ebx

    mov eax,1
    mov ebx,[ebp+8]
    int 0x80

    pop ebx
    leave
;-----------------------------------------------------------
; read - lee de file descriptor
;-----------------------------------------------------------
; Argumentos:
;    
;-----------------------------------------------------------
read:
    mov eax, SYS_read   ; SysRead 32-bit.
    ; Store the arguments to the system call 
    ; in the registers EBX, ECX, etc. 
    mov ebx, [ebp+8]
    mov ecx, [ebp+12]
    mov edx, [ebp+16]
    int 80h
    ret
;-----------------------------------------------------------
; write - escribe de file descriptor
;-----------------------------------------------------------
; Argumentos:
;   Primer argumento el file descriptor,
;   Segundo argumento     
;-----------------------------------------------------------
write:
    mov eax, SYS_write ; 4 = Syswrite
    mov ebx, [esp+4]
    mov ecx, [esp+8]
    mov edx, [esp+12]
    int 80h
    ret
;-----------------------------------------------------------
; open - abre un archivo.
;-----------------------------------------------------------
; Argumentos:
;    En ebp+8 se encuentra el archivo.
;-----------------------------------------------------------
open:
    mov eax, SYS_open       ; SYS_open equ 5.
    mov ebx, [ebp+8]        ; fileName.
    mov ecx, 0              ; for read only access.
    mov edx, 0777           ; read, write and execute by all.
    int 0x80
    ret
;-----------------------------------------------------------
; close - cierra un archivo.
;-----------------------------------------------------------
; Argumentos:
;    En ebp+8 se encuentra el archivo.
;-----------------------------------------------------------
close: 
    mov eax, SYS_close      ; SYS_close equ 6.
    mov ebx, [ebp+8]        ; fileName.
    int 0x80
    ret
section .data
    STDIN equ 0
    STDOUT equ 1
    STDERR equ 2

    LF equ 10
    NULL equ 0

    SYS_exit equ 1
    SYS_read equ 3
    SYS_write equ 4
    SYS_open equ 5
    SYS_close equ 6