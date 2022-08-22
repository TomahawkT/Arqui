GLOBAL print
GLOBAL exit
GLOBAL numtostr
GLOBAL factorial
GLOBAL to_upper
GLOBAL println

section .rodata
	nter db 10

section .text

;-----------------------------------------------------------
; print - imprimer una cadena en la salida estandar
;-----------------------------------------------------------
; Argumentos:
;	ebx: cadena a imprimer en pantalla, terminada con 0
;-----------------------------------------------------------
print:
	pushad		; hago backup de los registros

	call strlen
	mov ecx, ebx	; la cadena esta en ebx
	mov edx, eax	; en eax viene el largo de la cadena

	mov ebx, 1		; FileDescriptor (STDOUT)
	mov eax, 4		; ID del Syscall WRITE
	int 80h
	
	popad 		; restauro los registros
	ret	
	
;-----------------------------------------------------------
; exit - termina el programa
;-----------------------------------------------------------
; Argumentos:
;	ebx: valor de retorno al sistema operativo
;-----------------------------------------------------------
exit:
	mov eax, 1		; ID del Syscall EXIT
	int 80h			; Ejecucion de la llamada


;-----------------------------------------------------------
; strlen - calcula la longitud de una cadena terminada con 0
;-----------------------------------------------------------
; Argumentos:
;	ebx: puntero a la cadena
; Retorno:
;	eax: largo de la cadena
;-----------------------------------------------------------
strlen:
	push ecx ; preservo ecx	
	push ebx ; preservo ebx
	pushf	; preservo los flags

	mov ecx, 0	; inicializo el contador en 0
.loop:			; etiqueta local a strlen
	mov al, [ebx] 	; traigo al registo AL el valor apuntado por ebx
	cmp al, 0	; lo comparo con 0 o NULL
	jz .fin 	; Si es cero, termino.
	inc ecx		; Incremento el contador
	inc ebx
	jmp .loop
.fin:				; etiqueta local a strlen
	mov eax, ecx	
	
	popf
	pop ebx ; restauro ebx	
	pop ecx ; restauro ecx
	ret
	
;-----------------------------------------------------------
; numtostr - convierte un entero en un string guardandolo en 
; el stack
;-----------------------------------------------------------
; Argumentos:
;	el numero entero de 32 bit que se recibe en el stack
; ESP +4 a convertir
; Retorno:
;	los caracteres ASCII en el stack se devuelven  
;-----------------------------------------------------------
numtostr:
    push ebp
    mov ebp, esp ;guardo el puntero del stack
    pushad
    mov edx, 0 ; pongo la parte que no uso de la direccion en 0
    mov ecx, 10 ; quiero dividir por 10
    mov eax, dword [ebp+8] ; copio el numero
    mov ebx, esp ; marco la posicion del para empezar a copiar el numero
	sub esp, 11
    dec ebx ; me paro en la ultima posicion posible para el numero para empezar a colocar de atras
    mov byte [ebx], 0 ; pongo el final del numero
    dec ebx
	mov byte [ebx], 10
	dec ebx
.loop: 
    div ecx ; divido eax por ecx
    add dl,'0' ; el resto se guarda en edx pero como se que es menor a 10 entonces entra en dl, le sumo 30 a dl para que quede el ascii del numero ya que 30 es 0
    mov [ebx], dl
    cmp eax,0 ;en eax queda el resultado de div, comparo con 0 para ver si termine o no 
	jz .end
    dec ebx
	mov edx,0 ; reseteo esta parte para que no la use para dividir
	jmp .loop
.end:
    call print
	add esp,11
    popad
    mov esp, ebp
	pop ebp
    ret
	 
;-----------------------------------------------------------
; factorial - calcula el factorial de un numero
;-----------------------------------------------------------
; Argumentos:
;	el numero entero de 32 bit que se recibe en ebx.
; Retorno:
;	deja en ebx el factorial.
;-----------------------------------------------------------
factorial:
	push eax
	push ecx
	push edx
	pushf
	mov ecx, ebx
	mov eax, 1
.loop:
	cmp ecx, 1
	je .end
	mul ecx
	dec ecx
	jmp .loop
.end:
	mov ebx, eax
	popf
	pop edx
	pop ecx
	pop eax
	ret

println:
	pushad

	mov ecx,nter
	mov edx,1
	mov ebx,1
	mov eax,4
	int 80h

	popad
	ret

; recibe en ebx el puntero al string terminado en 0
to_upper:
    pushad
    mov ecx,0 ; counter
.loop:
    mov al,[ebx]
    cmp al,0
    jz .fin
    cmp al,96
    js .next
    cmp al,123
    jns .next
    sub al,32
    mov [ebx],al
.next:
    inc ecx
    inc ebx
    jmp .loop
.fin:
    mov eax,ecx
    popad
    ret
