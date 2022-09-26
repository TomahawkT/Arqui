#include <stdio.h>
extern int CheckLong(void * array, int size);

int main(void){
    if(CheckLong("hola", 4)==0){
        printf("funciona\n");
    }
}