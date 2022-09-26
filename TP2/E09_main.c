#include <stdio.h>
extern int read(int file_descriptor, char *buffer, int size);
extern int write(int file_descriptor, char *buffer, int size);
extern int open(char *file_name, int access_mode, int file_permissions);
extern int close(unsigned int fd);

int main(int argc, char *argv[])
{
    int size = 10;
    char buffer[size];

    read(0, buffer, size);
    write(1, buffer, size);
}