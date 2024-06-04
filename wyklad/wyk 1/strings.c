#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("strings.c\n\n");

    void *heap = malloc(1);

    printf("heap = %p\n", heap);
    printf("main = %p\n\n", main);

    char *s1 = "ala ";
    char s2[] = "ala ";
    char s3[] = {'a', 'l', 'a', ' ', '\0'};

    printf("%s\n", s1);
    printf("%s\n", s2);
    printf("%s\n\n", s3);

    printf("s1 = %p\n", s1);
    printf("s2 = %p\n", s2);
    printf("s3 = %p\n\n", s3);

    printf("sizeof(s1) = %d\n", sizeof(s1));
    printf("sizeof(s2) = %d\n\n", sizeof(s2));

    printf(" s1 = %p\n", s1);
    printf("&s1 = %p\n\n", &s1);

    printf(" s2 = %p\n", s2);
    printf("&s2 = %p\n\n", &s2);

    return 0;
}

/*
Windows 10
TDM-GCC 4.9.2

00C433A0 [ ][ ][ ][ ]                    | heap

0061FE98 [00404022]                  s1  | stack
0061FE93 ['a']['l']['a'][' ']['\0']  s2  |
0061FE8E ['a']['l']['a'][' ']['\0']  s3  |

00404022 ['a']['l']['a'][' ']['\0']      |
                                         |
00401500 [ ][ ][ ][ ]  main              | text
*/

/*
Ubuntu 20.04.5 LTS
gcc 9.4.0

ffc7f687 ['a']['l']['a'][' ']['\0']  s3  | stack
ffc7f682 ['a']['l']['a'][' ']['\0']  s2  |
ffc7f678 [565c602a]                  s1  |

575db5b0 [ ][ ][ ][ ]                    | heap

565c602a ['a']['l']['a'][' ']['\0']      |
                                         |
565c522d [ ][ ][ ][ ]  main              | text
*/

/*
https://www.geeksforgeeks.org/whats-difference-between-char-s-and-char-s-in-c/
*/

