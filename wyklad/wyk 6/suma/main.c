#include <stdio.h>
#include <stdlib.h>

extern int suma(int, int);

int main() {
    int a;
    int b;
    
    printf("a = "); scanf("%d", &a);
    printf("b = "); scanf("%d", &b);
    
    int suma_ = suma(a, b);
    
    printf("\na + b = %d\n", suma_);
    
    return 0;
}

// gcc main.c suma.c -o suma.exe -m32

