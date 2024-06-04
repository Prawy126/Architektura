#include <stdio.h>
#include <stdlib.h>

extern int suma2(int, int);

int main() {
    int a;
    int b;
    
    printf("a = "); scanf("%d", &a);
    printf("b = "); scanf("%d", &b);
    
    int suma = suma2(a, b);
    
//  addr    
    
    printf("\na + b = %d\n", suma);
    
    return 0;
}

/*
nasm suma2.asm -o suma2.o -f win32

gcc -c main2.c -o main2.o -m32

gcc main2.o suma2.o -o suma2.exe -m32
*/

