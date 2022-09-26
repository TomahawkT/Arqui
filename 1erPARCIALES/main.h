#ifndef _MAINH
#define _MAINH

/* FileDescriptors */
#define STDIN 0
#define STDOUT 1
#define STDERR 2

/* sys_open permisos con los que abro el archivo */
// flags
#define _O_RDONLY   0x000 // Read only
#define _O_WRONLY   0x001 // Write only
#define _O_RDWR     0x002 // Read & Write
#define _O_CREAT    0x040 // Create
#define _O_TRUNC    0x200 // ?
#define _O_APPEND   0x400 // Apprend

/* sys_open permisos con los que se crea el archivo */
// mode
#define S_IXUSR 100 // owner exec perm
#define S_IWUSR 200 // owner write perm
#define S_IRUSR 400 // owner read perm
#define S_IRWX  700 // owner read write exec perm

/* MACROS */
#define BUFFER_SIZE 5 5 + 4 + 1
#define NUM_SIZE 5

extern int sys_read(int fd, void * buffer, int bytes);
extern int sys_write(int fd, void * buffer, int bytes);
extern int sys_open(const char * path, int flags, int mode);
extern int sys_close(int fd);

#endif
