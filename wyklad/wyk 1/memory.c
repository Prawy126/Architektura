#include <stdio.h>
#include <stdlib.h>

int a;
int b;

int c = 1;
int d = 2;

int main(int argc, char *argv[]) {
    printf("memory.c\n\n");

    void *x;
    void *y;

    x = malloc(sizeof(int));
    y = malloc(sizeof(int));

    *(int*)x = 5;
    *(int*)y = 7;

    printf("main = %p\n\n", &main);

    printf("&a = %p\n", &a);
    printf("&b = %p\n\n", &b);

    printf("&c = %p\n", &c);
    printf("&d = %p\n\n", &d);

    printf("&argc = %p\n", &argc);
    printf("&argv = %p\n\n", &argv);

    printf("&x = %p\n", &x);
    printf("&y = %p\n\n", &y);

    printf("x = %p\n", x);
    printf("y = %p\n\n", y);

    printf("*(int*)x = %i\n", *(int*)x);
    printf("*(int*)y = %i\n\n", *(int*)y);

    return 0;
}

/*
Ubuntu 20.04.5 LTS
gcc 9.4.0

ffd85700 [ ][ ][ ][ ]  argc  | stack
ffd856bc [ ][ ][ ][ ]  argv  |
                             |
ffd856c8 [5754f5c0]    y     |
ffd856c4 [5754f5b0]    x     |

         [ ][ ][ ][ ]        |
         [ ][ ][ ][ ]        |
         [ ][ ][ ][ ]        |
5754f5c0 [7][0][0][0]  *y    |
         [ ][ ][ ][ ]        |
         [ ][ ][ ][ ]        |
         [ ][ ][ ][ ]        |
5754f5b0 [5][0][0][0]  *x    | heap

56563018 [ ][ ][ ][ ]  a     |
56563014 [ ][ ][ ][ ]  b     | uninitialized data

5656300c [2][0][0][0]  d     |
56563008 [1][0][0][0]  c     | initialized data

5656022d [ ][ ][ ][ ]        | main
*/

/*
Windows 10
TDM-GCC 4.9.2

         [ ][ ][ ][ ]        |
         [ ][ ][ ][ ]        |
         [ ][ ][ ][ ]        |
00A333B0 [7][0][0][0]  *y    |
         [ ][ ][ ][ ]        |
         [ ][ ][ ][ ]        |
         [ ][ ][ ][ ]        |
00A333A0 [5][0][0][0]  *x    | heap

0061FEB4 [ ][ ][ ][ ]  argv  | stack
0061FEB0 [ ][ ][ ][ ]  argc  |
                             |
0061FE9C [00A333A0]    x     |
0061FE98 [00A333B0]    y     |

00405434 [ ][ ][ ][ ]  b     |
00405430 [ ][ ][ ][ ]  a     | uninitialized data

00403008 [2][0][0][0]  d     |
00403004 [1][0][0][0]  c     | initialized data

00401500 [ ][ ][ ][ ]        | main
*/

