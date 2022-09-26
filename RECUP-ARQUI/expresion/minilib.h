#define S_IRWXU 0700 // USER read write exec perm 
#define _O_RDWR 0x002 // Read & Write
#define STDERR 2


extern int sys_read(int fd, void * buffer, int bytes);
extern int sys_write(int fd, void * buffer, int bytes);
extern int sys_open(const char * path, int flags, int mode);
extern int sys_close(int fd);
extern void sys_exit(int errno);
