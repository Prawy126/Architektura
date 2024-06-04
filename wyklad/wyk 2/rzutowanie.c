#include <stdio.h>

int main() {
    printf("rzutowanie.c\n\n");

    int x = 0x12345678;

    /*
    __            char
    78 56 34 12
    _____         short
    78 56 34 12
    ___________   int
    78 56 34 12
    */

    char byte = (char)x;
    short word = (short)x;
    int dword = (int)x;

    printf("x = %x\n", x);

    printf("\n");

    printf("byte  = %x\n", byte);
    printf("word  = %x\n", word);
    printf("dword = %x\n", dword);

    return 0;
}

