#include <stdint.h>
#include <naiveConsole.h>

uint64_t sys_exit(){
    ncPrint("Exit");
    return 0;
}

uint64_t sys_write(int fd,char * str, int length){
    switch (fd){
        case 1:
            ncPrint(str);
            break;
        case 2:
            ncPrintAttribute(str, 0x04);
            break;
        default:
            break;
    }
    return 0;
}