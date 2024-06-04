#include <stdio.h>

int main() {
    printf("pointers.c\n\n");

    int x;
    int y;

    printf("&x = %p\n", &x); /* &x to adres zmiennej x */
    printf("&y = %p\n", &y); /* &y to adres zmiennej y */

    /* gwiazdka przy deklaracji zmiennej wskaznikowej */

    int *w; /* w to wskaznik na zmienna typu int
               w przechowuje adres zmiennej typu int */

    w = &x; /* do w podstawiamy adres zmiennej x */

    printf("w = %p\n\n", w);

    /* gwiazdka jako operator wyluskania */

    *w = 5; /* zapis wartosci 5 do zmiennej x typu int
               bo w to wskaznik na zmienna x typu int */

    y = *w; /* odczyt wartosci 5 ze zmiennej x typu int
               bo w to wskaznik na zmienna x typu int */

    /*
             w
    &y       &x
    |        |
    [5 0 0 0][5 0 0 0]
     \__y__/  \__x__/

    */

    printf("x = %d\n", x);
    printf("y = %d\n", x);
    printf("*w = %d\n", *w);

    return 0;
}
