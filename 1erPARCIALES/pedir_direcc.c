#include <stdlib.h>
#include <stdio.h>
#include "syscalls32.h"
#include "functions.h"
#define BUFFER_MAX 42

extern int pedir_direcc_func(int value);

int main(void){
    int file_desc = sys_open("DatosA.txt",_O_RDONLY,S_IRUSR);
    if (file_desc < 0){
        char err_msg[] = "Hubo un error al abrir el programa\n";
        sys_write(STDERR,err_msg,strlen(err_msg));
        sys_exit(-1);
    }

    char number_string[BUFFER_MAX];
    int read_datosA =  sys_read(file_desc,number_string,BUFFER_MAX);

    if (read_datosA < 0){
        char err_msg[] = "Hubo un error al leer el programa\n";
        sys_write(STDERR,err_msg,strlen(err_msg));
        sys_exit(-1);
    }

    int number = 0;
    char * token = strtok(number_string," ");
    while (token != NULL){
        for(int i = 0; token[i] != NULL; i++){
            number = number * 10 + token[i] - '0';
        }
        token = strtok(NULL," ");
    }
    
    int direccion = pedir_direcc_func(number);
    
    printf("Numero en hexadecimal: %x\n", number);
    printf("Numero de la direccion del stack: %x\n", direccion);
    return 0;
    
}   
