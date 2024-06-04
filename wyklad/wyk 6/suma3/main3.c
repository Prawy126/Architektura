#include <stdio.h>
#include <stdlib.h>

extern int suma3(int, int);

int main() {
    int a;
    int b;
    
    printf("a = "); scanf("%d", &a);
    printf("b = "); scanf("%d", &b);
    
    int suma = suma3(a, b);
    
//  addr    
    
    printf("\na + b = %d\n", suma);
    
    return 0;
}

/*
nasm suma3.asm -o suma3.o -f win32

gcc -c main3.c -o main3.o -m32

gcc main3.o suma3.o -o suma3.exe -m32
*/

