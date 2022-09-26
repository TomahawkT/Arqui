#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#define BUFFER_MAX 20
#define FILE_MAX 1000

#define STDIN 0
#define STDOUT 1
#define STDERR 2

// sys_open permisos con los que abro el archivo
// flags
#define _O_RDONLY   0x000 // Read only
#define _O_WRONLY   0x001 // Write only
#define _O_RDWR     0x002 // Read & Write
#define _O_CREAT    0x040 // Create
#define _O_TRUNC    0x200 // Para reescribir el archivo
#define _O_APPEND   0x400 // Append

// sys_open permisos con los que se crea el archivo
// mode
#define S_IXUSR 0100 // USER exec perm
#define S_IWUSR 0200 // USER write perm
#define S_IRUSR 0400 // USER read perm
#define S_IRWXU 0700 // USER read write exec perm 


extern int sys_read(int fd, void * buffer, int bytes);
extern int sys_write(int fd, void * buffer, int bytes);
extern int sys_open(const char * path, int flags, int mode);
extern int sys_close(int fd);
extern void sys_exit(int errno);
extern void swapper(int fd ,int nums[BUFFER_MAX], int cant_args);

int main(void){

    int fd = sys_open("DatosA.txt",_O_RDONLY,S_IRUSR);
    if (fd<0){
        char err_msg[] = "Hubo un error al abrir el archivo\n";
        sys_write(STDERR,err_msg,strlen(err_msg));
        sys_exit(-1);
    }

    char file[FILE_MAX] = {0};
    int read = sys_read(fd,file,FILE_MAX);
    if (read<0){
        char err_msg[] = "Hubo un error al leer el archivo\n";
        sys_write(STDERR,err_msg,strlen(err_msg));
        sys_exit(-1);
    }

    int nums[BUFFER_MAX] = {0};
    char * token = strtok(file," ");
    int idx=0;
    while (token != NULL){
        nums[idx++] = atoi(token);
        token = strtok(NULL," ");
    }

    int fd2 = sys_open("DatosB.txt", _O_RDONLY | _O_CREAT, S_IWUSR);
    if (fd2<0){
        char err_msg[] = "Hubo un error al abrir el archivo\n";
        sys_write(STDERR,err_msg,strlen(err_msg));
        sys_exit(-1);
    }

    swapper(fd2,nums,idx);

    sys_close(fd);
    return 0;
}