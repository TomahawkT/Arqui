GLOBAL _start

section .text
_start:
    mov ebp,esp ; pongo en el ebp el lugar donde apunta el esp
    mov eax,ebp
    add eax,8  ; pusheo la direccion del primer argumento asi que da como puntero
    
    push DWORD eax
    push DWORD [ebp] ; pusheo la cantidad de argumentos
    call main ; llamo a main

    mov ebx, eax ;  pongo el retorno de main en ebx
    mov eax,1 ; codigo del syscall de exit
    int 80h ; hago el syscall

    