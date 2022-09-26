#define is_letter(x) x >= 'a' && x <= 'z' ? 1 : 0
#define dif 'a' - 'A'
#include <string.h>

int sys_read(int fd, void * buffer, int bytes);

void toUpper(char * string){
    char buffer[100] = {0};

    sys_read(0, &buffer, 100);

    int len = strlen(string);
    for(int i = 0 ; i < len ; i++){
        if(is_letter(string[i])){
            string[i] -= dif;
        }
    }
}