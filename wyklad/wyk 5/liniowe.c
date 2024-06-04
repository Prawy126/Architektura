#include <stdio.h>

/* Rownanie liniowe

ax + b = 0

ax = -b

Z1: a == 0

0 = -b

b == 0  =>  x nalezy do R
b != 0  =>  x nalezy do zbioru pustego

Z2: a != 0

x = -b/a
*/

int main() {
    double a, b;

    printf("a = "); scanf("%lf", &a);
    printf("b = "); scanf("%lf", &b);

    printf("\n");

    if (a == 0) {
        if (b == 0) printf("x nalezy do R\n");
        if (b != 0) printf("x nalezy do zbioru pustego");
    } else {
        double x = -b/a;

        printf("x = %f\n", x);
    }
}

