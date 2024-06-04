#include <stdio.h>

int main(int argc, char *argv[]) {
    printf("strings2.c\n\n");

    char *s1 = "ala i ola";
    char *s2 = "tola i lola";
    char *s3 = "bolek i lolek";

    char *tab[] = {s1, s2, s3};

    printf("s1 = %s\n", tab[0]);
    printf("s2 = %s\n", tab[1]);
    printf("s3 = %s\n", tab[2]);

    printf("\n");

    printf("s1 = %s\n", *tab);
    printf("s2 = %s\n", *(tab+1));
    printf("s3 = %s\n", *(tab+2));

    return 0;
}

