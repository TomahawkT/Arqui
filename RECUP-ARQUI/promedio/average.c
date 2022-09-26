#define STDOUT 1
#define ERRMSG "Invalid qty of arg\n"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

extern int sys_write(int fd, void * buffer, int bytes);

void getAverage(int argc, char * argv[]){
    if(argc < 2){
        sys_write(STDOUT, ERRMSG, strlen(ERRMSG));
    }
     
    float sum = 0;
    for(int i = 1 ; i < argc ; i++ ){
        float aux = atof(argv[i]);
        sum += aux;
    }
    float avg = sum/(argc - 1);

    char buffer[20] = {0};
    sprintf(buffer, "Average: %.2f\n", avg);
    sys_write(STDOUT, buffer, strlen(buffer));
}