#include <stdio.h>

int main() {
    printf("rzutowanie2.c\n\n");

    int x = 0x12345678;

    /*
     __                char
    [78][56][34][12]
    |   |   |   |      pointers
    p   p+1 p+2 p+3

     __  __            short
    [78][56][34][12]
    |       |          pointers
    p       p+1

     __  __  __  __    int
    [78][56][34][12]
    |                  pointers
    p
    */

    char *p_byte = (char*)&x;
    short *p_word = (short*)&x;
    int *p_dword = (int*)&x;

    printf("x = %x\n", x);

    printf("\n");

    printf("&x = %p\n", &x);

    printf("\n");

    printf("*(p_byte)   = %x\n", *p_byte);
    printf("*(p_byte+1) = %x\n", *(p_byte+1));
    printf("*(p_byte+2) = %x\n", *(p_byte+2));
    printf("*(p_byte+3) = %x\n", *(p_byte+3));

    printf("\n");

    printf("*(p_word)   = %x\n", *p_word);
    printf("*(p_word+1) = %x\n", *(p_word+1));

    printf("\n");

    printf("*(p_dword)  = %x\n", *p_dword);

    return 0;
}

