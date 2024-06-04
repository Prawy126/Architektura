#include <stdio.h>

struct Complex {
    double re;
    double im;
};

int main() {
    /* Sposob 1 */

    struct Complex z1;

    z1.re = 1;
    z1.im = 2;

    /* Sposob 2 */

    struct Complex z2;

    z2 = (struct Complex){3, 4};

    /* Sposob 3 */

    struct Complex z3 = {5, 6};

    /*
    dostep do struktury - sposob 1
    */

    double re = z1.re;
    double im = z1.im;

    printf("z1.re = %lf\n", re);
    printf("z1.im = %lf\n\n", im);

    /*
    dostep do struktury przez wskaznik - sposob 2
    */

    struct Complex *ptr1 = &z2;

    re = ptr1 -> re;
    im = ptr1 -> im;

    printf("z2.re = %lf\n", re);
    printf("z2.im = %lf\n\n", im);

    /*
    dostep do struktury przez wskaznik - sposob 3
    */

    struct Complex *ptr2 = &z3;

    re = (*ptr2).re;
    im = (*ptr2).im;

    printf("z3.re = %lf\n", re);
    printf("z3.im = %lf\n\n", im);

    return 0;
}

