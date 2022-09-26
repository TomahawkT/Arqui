;    Desarrolle un codigo de que combine ASM y C que permita recibir 
;    como argumentos tres numeros A, B, C (decimales con signo).
;    Calcule los ceros de la ecuacion de segundo grado y = ax2 + bx + c
GLOBAL _start
    EXTERN calcZerosPolynomial
    EXTERN printf


section .text  

_start:
    mov ebp, esp
    mov eax, [ebp]
    cmp eax, 4          ; Solo calculo si la cantidad de argumentos + path = 4 
    jnz error
    push retArray
    push DWORD [ebp+16] ; Pusheo C
    push DWORD [ebp+12] ; Pusheo B
    push DWORD [ebp+8]  ; Pusheo A
    call calcZerosPolynomial ; devuelve un vector de 2 elementos con los ceros del polinomio

    mov esi, retArray
    ; Zona de parche asqueroso
    push DWORD [esi+12]  ; Pusheo los ultimos 4 bytes de la 2da raiz
    push DWORD [esi+8]   ; pusheo los primeros 4 bytes de la 2da raiz
    push DWORD [esi+4]  ; pusheo los ultims 4 bytes de la 1er raiz
    push DWORD [esi]    ; Pusheo los primeros 4B de la 1er raiz
    push fmtstr         ; Pusheo el string de formato
    ; Zona de parche asqueroso
    call printf

    mov eax, 1
    mov ebx, 0
    int 80h

error:
    mov eax, 1
    mov ebx, 1
    int 80h

section .rodata
    fmtstr: db "Ceros del polinomio: [%.2f, %.2f]", 0xA, 0x0

section .data
    retArray: dd 0, 0;