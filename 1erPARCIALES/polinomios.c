/*  
    Desarrolle un codigo de que combine ASM y C que permita recibir 
    como argumentos tres numeros A, B, C (decimales con signo).
    Calcule los ceros de la ecuacion de segundo grado y = ax2 + bx + c
*/ 

#include <stdio.h>
#include <stdlib.h>
#include <math.h>


void calcZerosPolynomial(char * a, char * b, char * c, double resultArray[2]) {
    double cDouble = atof(c);
    double bDouble = atof(b);
    double aDouble = atof(a);

    double det = bDouble*bDouble - 4*aDouble*cDouble;
    if ( aDouble == 0 || det < 0 ) {
        return;
    }
    resultArray[0] = (-bDouble-sqrt(det))/(2*aDouble);
    resultArray[1] = (-bDouble+sqrt(det))/(2*aDouble);
    
    return;
}