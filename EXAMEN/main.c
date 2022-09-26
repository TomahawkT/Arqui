#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define STDIN 0
#define STDERR 2
#define BUFFER_MAX 50
#define NUMBER_MAX 6

extern int sys_read(int fd, void * buffer, int bytes);
extern void sys_exit(int errno);
extern int sys_write(int fd, void * buffer, int bytes);

extern void binary_search(int number, int right, char* args[]);

void binary_searcher(int argc, char * argv[]){

    /*printf("Ingrese los numeros del array");
    char input[BUFFER_MAX] = {0};
    int read = sys_read(STDIN, input, BUFFER_MAX);
    if (read<0){
        char err_msg[] = "Hubo un error al ingresar el array\n";
        sys_write(STDERR,err_msg,strlen(err_msg));
        sys_exit(-1);
    } */

    char search_number[NUMBER_MAX] = {0};
    int read_2 = sys_read(STDIN, search_number, BUFFER_MAX);
    if (read_2<0){
        char err_msg[] = "Hubo un error al ingresar el numero a buscar\n";
        sys_write(STDERR,err_msg,strlen(err_msg));
        sys_exit(-1);
    }

    for(int i=0; i< argc; i++){
        printf("Vector: %s", argv[i]);
    }
    /*int i=1;
    char numbers[argc-1];
    while (i <= argc)
    {
        numbers[i-1] = atoi(argv[i]);
        i++;
    }
    for(int i=0; i< argc; i++){
        printf("Vector: %d\n", numbers[i]);
    }*/
    



    int number = atoi(search_number);
    binary_search(number+'0', argc-1, argv);
    return;
}

int main(int argc, char * argv[]){
    binary_searcher(argc, argv);
    return 0;
}