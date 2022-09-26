#include "main.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    //  Abrimos los files.
    int fileA_descriptor = sys_open("DatosA.txt", _O_RDONLY, S_IRUSR);
    int fileB_descriptor = sys_open("DatosB.txt", _O_RDONLY, S_IRUSR);
    if(fileA_descriptor == -1 || fileB_descriptor == -1) {
        printf("No se pudo abrir uno o mas archivos.");
        return 1;
    }

    //  Leo los archivos
    char bufferA[BUFFER_SIZE] = {0};
    char bufferB[BUFFER_SIZE] = {0};

    int read_code_A = sys_read(fileA_descriptor, bufferA, BUFFER_SIZE);
    int read_code_b = sys_read(fileB_descriptor, bufferB, BUFFER_SIZE);

    //  Proceso DatosA.txt
    int numsA[NUM_SIZE];
    const char *delim = " ";
    char* tokenA = strtok(bufferA, delim);
    for(int i = 0; i < NUM_SIZE && tokenA != NULL; i++) {
        numsA[i] = atoi(tokenA);
        tokenA = strtok(NULL, delim);
    }

    //  Proceso DatosB.txt
    int numsB[NUM_SIZE];
    char* tokenB = strtok(bufferB, delim);
    for(int i = 0; i < NUM_SIZE && tokenB != NULL; i++) {
        numsB[i] = atoi(tokenB);
        tokenB = strtok(NULL, delim);
    }

    //  Busco la interseccion.
    int found = 0;
    char bufferC[BUFFER_SIZE] = {0};
    for(int i = 0; i < NUM_SIZE; i++) {
        found = 0;
        for(int j = 0; j < NUM_SIZE && !found; j++) {
            if(numsA[i] == numsB[j]) {
                found = 1;
                sprintf(bufferC + strlen(bufferC), "%d", numsA[i]);
                if(i != 4)
                    sprintf(bufferC + strlen(bufferC), " ");
            }
        }
    }
    sprintf(bufferC + strlen(bufferC), "\n");
    
    int fileC_descriptor = sys_open("DatosC.txt", _O_WRONLY, S_IWUSR);
    if(fileC_descriptor == -1) {
        printf("No se pudo abrir el archivo.");
        return -1;
    }
    sys_write(fileC_descriptor, bufferC, strlen(bufferC));

    sys_close(fileA_descriptor);
    sys_close(fileB_descriptor);
    sys_close(fileC_descriptor);

    return 0;
}