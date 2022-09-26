
section .text

;-----------------------------------------------------------
; sys_open - gets a file descriptor for a file
;-----------------------------------------------------------
; Argumentos:
;   const char * filename
;   int flags
;   umode_t mode
; Returns:
;   int fd for the file
;   -1 if there was an error
;-----------------------------------------------------------
global sys_open
sys_open:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, 5
    mov ebx, [ebp + 8] ; filename
    mov ecx, [ebp + 12] ; flasgs
    mov edx, [ebp + 16] ; mode
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret

;-----------------------------------------------------------
; sys_close - closes a fd
;-----------------------------------------------------------
; Argumentos:
;   int fd
; Returns:
;   int 0 if succeded
;   -1 on error
;-----------------------------------------------------------
global sys_close
sys_close:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, 6
    mov ebx, [ebp + 8] ; fd
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret

;-----------------------------------------------------------
; sys_read - guarda en buff los primeros count bytes de fd
;-----------------------------------------------------------
; Argumentos:
;   int fd
;   (void *) buffer
;   size_t count/length
; Returns:
;   ssize_t number of bytes read
;   0 means EOF was reached
;-----------------------------------------------------------
global sys_read
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

;-----------------------------------------------------------
; sys_exit - corta la ejecucion del programa
;-----------------------------------------------------------
; Argumentos:
;   int error_code
;-----------------------------------------------------------
global sys_exit
sys_exit:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, 1
    mov ebx, [ebp + 8]
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret

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