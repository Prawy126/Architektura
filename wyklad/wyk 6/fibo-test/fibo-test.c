#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern int fibo(int);

/*
Ciag Fibonacciego

0   1   2   3   4   5   6    indeksy
1   1   2   3   5   8   13   wartosci
*/

int fibo1(int n);

/*
r0  r1  r2
|---|---|
0   1   2   3   4   5   6    indeksy
1   1   2   3   5   8   13   wartosci
    |---|---|
    r0  r1  r2

Przesuniecie ramki w prawo:

r0 = r1
r1 = r2
r2 = r0 + r1
*/

int fibo1(int n) {
    int r0 = 1;
    int r1 = 1;
    int r2 = 2;
    
    if (n == 0) return r0;
    if (n == 1) return r1;
    if (n == 2) return r2;
    
    int i;
    for (i = 3; i <= n; i++) {
        r0 = r1;
        r1 = r2;
        r2 = r0 + r1;
    }
    
    return r2;
}

int fibo2(int n);

/*
r0  r1
|---|
0   1   2   3   4   5   6    indeksy
1   1   2   3   5   8   13   wartosci
|   |---|
pom r0  r1

Przesuniecie ramki w prawo:

pom = r0
r0 = r1
r1 = pom + r0
*/

int fibo2(int n) {
    int r0 = 1;
    int r1 = 1;
    
    if (n == 0) return r0;
    if (n == 1) return r1;
    
    int i;
    for (i = 2; i <= n; i++) {
        int pom = r0;
        r0 = r1;
        r1 = pom + r0;
    }
    
    return r1;
}

int fibo3(int n);

/*
f(0) = 1
f(1) = 1
f(n) = f(n-1) + f(n-2)
*/

int fibo3(int n) {
    if (n == 0) return 1;
    if (n == 1) return 1;
    
    return fibo3(n-1) + fibo3(n-2);
}

int main(int argc, char *argv[]) {
    printf("fibo-test.c\n\n");
    
    int n;
    
    printf("n = "); scanf("%d", &n);
    
    printf("\n");
    
    printf("fibo(%d)  = %d\n", n, fibo(n));
    printf("fibo1(%d) = %d\n", n, fibo1(n));
    printf("fibo2(%d) = %d\n", n, fibo2(n));
    
    printf("\n");
    
    int limit = 1000*1000;
    
    clock_t start = clock();
    
    int i;
    for (i = 0; i < limit; i++) {
        fibo(n);
    }
    
    clock_t end = clock();
    
    printf("fibo  time = %d\n", end - start);
    
    start = clock();
    
    for (i = 0; i < limit; i++) {
        fibo1(n);
    }
    
    end = clock();
    
    printf("fibo1 time = %d\n", end - start);
    
    start = clock();
    
    for (i = 0; i < limit; i++) {
        fibo2(n);
    }
    
    end = clock();
    
    printf("fibo2 time = %d\n", end - start);
    
    return 0;
}

/*
nasm fibo.asm -o fibo.o -f win32

gcc -c fibo-test.c -o main.o -m32

gcc main.o fibo.o -o fibo-test.exe -m32
*/

