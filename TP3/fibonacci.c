#include <stdio.h>

int fibonacci(int n) {
   if(n <= 1){
      return n;
   }
   return (fibonacci(n-1) + fibonacci(n-2));
}

int main(void){
    int n=3;
    printf("Fibonacci de %d: %d\n",n, fibonacci(n));
    return 0;
}