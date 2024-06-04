#include <stdio.h>
#include <stdlib.h>

extern double pi();

int main() {
    
    const double PI = pi();
    
//  addr    
    
    printf("PI = %f\n", PI);
    
    return 0;
}

/*
nasm pi.asm -o pi.o -f win32

gcc -c main.c -o main.o -m32

gcc main.o pi.o -o pi.exe -m32
*/

