#include<stdio.h>
#include<stdlib.h>
#include<math.h>

void getRoots(char * n1, char * n2, char * n3, void * string){
    float a = atof(n1);
    float b = atof(n2);
    float c = atof(n3);

    float x1, x2;
    if(a != 0){
        float num = sqrt(b*b - 4*a*c);
        float den = 2*a;

        x1 = (-b + num)/den;
        x2 = (-b - num)/den;
    } else{
        x1 = x2 = -c/b;
    }
    sprintf(string, "x1: %.2f || x2: %.2f", x1, x2);
}