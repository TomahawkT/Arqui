#include <stdio.h>
#define DIM 20
int main(void){
    int arr1[DIM];
    int arr2[DIM] = {0};
    int arr3[DIM];
    arr3[10] = 55;
    int arr4[DIM] = {0};
    arr4[10] = 66;
    static int arr5[DIM];
    static int arr6[DIM] = {0};
    return 0;
}

