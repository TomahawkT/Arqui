extern void sys_exit(int errno);
extern int sys_read(int fd, void * buffer, int bytes);
extern int sys_write(int fd, void * buffer, int bytes);
extern int sys_open(const char * path, int flags, int mode);
extern int sys_close(int fd);
void getNums(char * buffer, int * nums);
void perr(const char * str);

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define _O_RDONLY   0x000 // Read only
#define _O_RDWR     0x002 // Read & Write
#define S_IRWXU 0700 // USER read write exec perm 
#define STDERR 2
#define _O_CREAT    0x040 // Create

#define MAX_NUMS 5
#define MAX_BUFF_SIZE MAX_NUMS*6+30

int main(int argc, char * argv[]){
    int fd1 = sys_open(argv[1], _O_RDONLY, S_IRWXU);
    int fd2 = sys_open(argv[2], _O_RDONLY, S_IRWXU);

    if(fd1 < 0 || fd2 < 0){
        perr("Could not open the files\n");
        sys_exit(fd1 < fd2 ? fd1 : fd2);
    }

    char buffer1[MAX_BUFF_SIZE] = {0};
    char buffer2[MAX_BUFF_SIZE] = {0};

    sys_read(fd1, buffer1, MAX_BUFF_SIZE);
    sys_read(fd2, buffer2, MAX_BUFF_SIZE);
    
    int nums1 [MAX_NUMS];
    int nums2 [MAX_NUMS];

    getNums(buffer1, nums1);
    getNums(buffer2, nums2);
    
    sys_open("./C.txt", _O_CREAT, S_IRWXU);
    int fdC = sys_open("./C.txt", _O_RDWR, 0);

    int found = 0;
    for(int j = 0 ; j < MAX_NUMS ; j++, found = 0){
        for(int i = 0 ; i < MAX_NUMS && !found ; i++){
            if(nums1[i] == nums2[j]){
                char aux[6]= {0};
                sprintf(aux, "%d\n", nums1[i]);
                sys_write(fdC, aux, strlen(aux));
                found = 1;
            }
        }
    }
    
}

void getNums(char * buffer, int * nums){
    char * token;
    char delim[2] = ",";
    token = strtok(buffer, delim);
    nums[0] = atoi(token);
    token = strtok(NULL, delim);
    for(int i = 1 ; i < MAX_NUMS && token != NULL ; i++){
        nums[i] = atoi(token);
        token = strtok(NULL, delim);
    }
}

void perr(const char * str) {
    sys_write(STDERR, (void *) str, strlen(str));
}