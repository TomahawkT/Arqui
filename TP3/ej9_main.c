#include <stdio.h>
#include <stddef.h>
#define O_CREAT 00000100

extern int close_program(int return_value);
extern ssize_t sys_write(int fd, void * buffer, size_t count);
extern ssize_t sys_read(int fd, void * buffer, size_t count);
extern int open_file(const char * filename, int flags, size_t mode);
extern int printf(const char * string, int size);
extern void exit(int status);

int main(int argc, char * argv[]){
    
}

