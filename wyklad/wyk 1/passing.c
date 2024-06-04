#include <stdio.h>

void value(int a) {
    a = 1;
}

void pointer(int *a) {
    *a = 1;
}

int main() {
    printf("passing.c\n\n");

    int a = 0;

    printf("a = %d\n", a);

    value(a);

    printf("a = %d\n", a);

    pointer(&a);

    printf("a = %d\n", a);

    return 0;
}
