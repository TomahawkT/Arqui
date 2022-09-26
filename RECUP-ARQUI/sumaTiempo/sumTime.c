extern void sys_exit(int errno);
extern int sys_read(int fd, void * buffer, int bytes);
extern int sys_write(int fd, void * buffer, int bytes);
extern int sys_open(const char * path, int flags, int mode);
extern int sys_close(int fd);

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define _O_RDWR     0x002 // Read & Write
#define S_IRWXU     0700 // USER read write exec perm 
#define STDERR      2
#define CLOCK_REALTIME 0
#define MAX_NUMS    10000

long sumNums(char * buffer){
    char * token;
    char delim[2] = "\n";
    long num = 0;
    token = strtok(buffer, delim);
    num = atol(token);
    token = strtok(NULL, delim);
    for(int i = 1 ; i < MAX_NUMS && token != NULL ; i++){
        num +=  atol(token);
        token = strtok(NULL, delim);
    }
    return num;
}

void perr(const char * str) {
    sys_write(STDERR, (void *) str, strlen(str));
}

typedef long int time_t;

typedef struct timespec2{
    time_t sec;
    long nanosec; // 0 - 999999999
} timespec2;

extern int sys_clock_gettime(int clock, timespec2 * tp);

static timespec2 startTime;
static timespec2 endTime;
static int endTimeFlag = 0;
static int startTimeFlag = 0;

int startClock() {
    endTimeFlag = 0;
    startTimeFlag = 1;
    return sys_clock_gettime(CLOCK_REALTIME, &startTime);
}

int endClock() {
    if(!startTimeFlag) {
        return -1;
    }
    endTimeFlag = 1;
    return sys_clock_gettime(CLOCK_REALTIME, &endTime);
}

int getClockInterval(long * sec, long * nanosec) {
    if(!endTimeFlag) {
        return -1;
    }
    double nanosecExp = 1/1000000000.0;
    double timePassed = (endTime.sec + endTime.nanosec*(nanosecExp)) - (startTime.sec + startTime.nanosec*(nanosecExp));
    (*sec) = (long) timePassed;
    (*nanosec) = (long)((timePassed - (*sec)) / nanosecExp);
    return 1;
}

int main(int argc, char * argv[]){
    int fd = sys_open("./DatosA.txt", _O_RDWR, S_IRWXU);
    if(fd < 0){
        perr("Could not open file");
    }

    char buffer[60000] = {0};

    startClock();
        sys_read(fd, buffer, 60000);
        long sum = sumNums(buffer);
    endClock();
    double sec, nan;
    getClockInterval(&sec, &nan);
    printf("La suma dio: %  \nTiempo: %ld nanosegundos\n", sum, nan);
    
}

