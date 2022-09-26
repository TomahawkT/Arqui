#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "minilib.h"

#define INVALID_EXP_LENGTH_ERR 1
#define INVALID_CHAR_ERR 2
#define MISSING_EQUAL_ERR 3
#define MAX_SYMBOLS 4               //Son 5 numeros y 4 simbolos

void formatError(int err, char letter);
int getcharfd(int fd);
void error(char * string, int err);

int main(int argc, char *argv[]){
    //Apertura del archivo
    int fd = sys_open(argv[1], _O_RDWR, S_IRWXU);

    //Checkeo posible error en la apertura del archivo
    if(fd < 0){
        char errArch[] = "No se pudo abrir el archivo\n";
        error(errArch, fd);
    }


    char curr;
    int suma = 1;
    int num = 0;
    int result = 0;

    int count = 0;

    while((curr = getcharfd(fd)) != '=' && curr != EOF){
        //Si es num lo agrego al num que previamente tenia
        //Respetando los ordenes de magnitud previos
        //Pasaje de ascii a int tmb
        if(curr >= '0' && curr <= '9'){
            num = 10 * num + curr - '0';
        }
        //En caso de que sea un simbolo de resta 
        //Resto el num y reseteo suma y num
        else if(curr == '-'){
            if(suma){
                result+= num;
            }else{
                result-= num;
            }
            suma = 0;
            num = 0;
            count ++;
         }
        //Equivalente a resta pero sumo el numero
        else if( curr == '+'){
            if(suma){
            result+= num;
            }else{
            result-= num;
            }
            suma = 1;
            num = 0;
            count ++;
        } 
        else{
            formatError(INVALID_CHAR_ERR, curr);    
        }
    }
    //Check de posibles errores en el expression
    if(count != 4){
        formatError(INVALID_EXP_LENGTH_ERR, curr);
    } else if(curr != '='){
        formatError(MISSING_EQUAL_ERR, curr);
    }  

    //Sumo el ultimo numero que quedo sin sumar
    if(suma)
        result += num;
    else
        result -= num;

    //Impresion del resultado por salida estandard
    char string[30] = {0};
    sprintf(string, "%d\n", result);
    sys_write(1, string, strlen(string));

    //Cierre del archivo
    sys_close(fd);

    return 0;
}  

void formatError(int err, char letter){
    char errFmt[60] = {0}; 
    switch(err) {
        case INVALID_EXP_LENGTH_ERR:
            sprintf(errFmt, "Invalid amount of nums in expression\n");
            break;
        case INVALID_CHAR_ERR:
            sprintf(errFmt, "Invalid equation format in character: %c\n", letter);
            break;
        case MISSING_EQUAL_ERR:
            sprintf(errFmt, "Missing equal symbol at the end of the expression\n");
    }
    error(errFmt, (int) letter);    
}

void error(char * string, int err){
        sys_write(STDERR, string, strlen(string));
        sys_exit(err);
}

int getcharfd(int fd) {
    char c;
    int read = sys_read(fd, &c, 1);
    if(read == 1) return c;
    if(read < 0 || read > 1) return -2;
    return -1;
}