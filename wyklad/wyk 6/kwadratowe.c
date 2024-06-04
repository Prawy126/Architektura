#include <stdio.h>
#include <math.h>

/*
Z: a != 0

a*x^2 + b*x + c = 0 

delta = b*b - 4*a*c

P1: delta < 0

brak pierwiastkow

P2: delta = 0

x0 = -b / (2*a)

P3: delta > 0

x1 = (-b - sqrt(delta)) / (2*a)
x2 = (-b + sqrt(delta)) / (2*a)
*/

int main() {
    printf("kwadratowe.c\n\n");
    
    double a, b, c;
    
    printf("a = "); scanf("%lf", &a);
    printf("b = "); scanf("%lf", &b);
    printf("c = "); scanf("%lf", &c);
    
    printf("\n");
    
    double delta = b*b - 4*a*c;
    
    if (delta < 0) {
        printf("brak pierwiastkow");
    } else {
        if (delta == 0) {
            double x0 = -b / (2*a);
            
            printf("x0 = %f\n", x0);
        } else {
            double x1 = (-b - sqrt(delta)) / (2*a);
            double x2 = (-b + sqrt(delta)) / (2*a);

            printf("x1 = %f\n", x1);
            printf("x2 = %f\n", x2);
        }
    }
}

