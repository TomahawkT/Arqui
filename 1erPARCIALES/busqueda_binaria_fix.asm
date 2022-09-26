GLOBAL  main
EXTERN printf
section  .text 
main:
        push  ebp
        mov   ebp,esp

        call cargo_datos
        
        mov   ecx, [ebp+8]
        cmp   ecx, 1
        je    falta_parm
	mov   ecx,[ebp+12]
	mov   edi,[ecx+4]
        
        call  atoi
        cmp   eax,0
        jl    errorparm
        
        xor   ecx, ecx         
        xor   edx, edx 
        
        mov  dh, al            
        lea   esi, [arr]        

while:
        xor   eax, eax          
        xor   ebx, ebx          
        mov   ah, [left]       
        mov   al, [right]       
        mov   bl, 2             
        cmp   al, ah            
        jae   iteration         
        jmp   not_found         

iteration:
        sub   al, ah            
        xor   ah, ah            
        div   bl               
                                 
        xor   ah, ah            
        add   al, [left]        
                                                         
        mov   [mid], al         
        push  esi              
        add   esi, eax         
        mov   dl, [esi]         
        pop   esi               
        cmp   dh, dl            
        je    found             
        jb    below             
        ja    above
          
found:
        mov   cx, 1             
        inc   byte [iter]       
        call  printscr         
        jmp   exit
            
below:
        dec   byte [mid]        
        mov   cl, [mid]         
        mov   [right], cl       
        inc   byte [iter]       
        jmp   while
  
above:         
        inc   byte [mid]        
        mov   cl, [mid]         
        mov   [left], cl       
        inc   byte [iter]       
        jmp   while
            
not_found:
        mov   cx, 0            
        call  printscr          
        jmp   exit
              
printscr:
        cmp   cx, 1             
        jne   not_ok           
        push  msg_ok           
        call  printf            
        add   esp, 4            
        ret   
                  
not_ok:
        push  msg_not_so_ok     
        call  printf            
        add   esp, 4            
        ret                    

exit:
        pop ebp 
        ret
     
falta_parm:
        push fparm
        call printf
        add esp,4
        jmp exit
       
errorparm: 
        push error_parm
        call printf
        add esp,4 
        jmp exit

atoi:
        mov eax,0
        push ebx

convert:
        movzx  esi, byte [edi]
        mov bl,byte [edi]
        test esi,esi
        je done  
        cmp bl," "
        je done
        cmp esi,48
        jl error
        cmp esi,57 
        jg error  
        sub esi,48
        imul eax,10
        add eax,esi  
        inc edi
        jmp convert

error:   
        mov eax, -1         
done:   
        pop ebx
        ret

cargo_datos:
        mov ecx,0
        mov ebx,filename
        mov eax,5
        int 80h
          
	mov edx,150
        mov ecx,buffer 
        mov ebx,eax
        ;mov eax, 4         ; Syscall write.
        mov eax, 3          ; Syscall de read.
        int 80h 

        mov  ecx,30
        mov  edi,buffer
        mov  edx,arr

ciclo:    
        call atoi 
        mov  dword [edx],eax           
        add edx,1
        add edi,1
        dec ecx
          
        cmp ecx,0
        jne ciclo

section .data
    filename       db "datos.txt",0
    iter           db 0
    left           db 0
    right          db 29
    mid            db 0
    msg_ok         db "Encontrado", 10, 0
    msg_not_so_ok  db "No se encuentra", 10, 0
    error_parm     db "argumento incorrecto",10,0 
    fparm          db "falta argumento",10,0

section .bss
    arr      resb 30
    buffer   resb 150