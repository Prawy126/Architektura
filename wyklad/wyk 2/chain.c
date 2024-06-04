#include <stdio.h>

int main() {
    printf("chain.c\n\n");

    int x = 1;

    int *wsk_na_int = &x;
    int **wsk_na_wsk_na_int = &wsk_na_int;
    int ***wsk_na_wsk_na_wsk_na_int = &wsk_na_wsk_na_int;

    printf("x = %d\n", *wsk_na_int);
    printf("x = %d\n", **wsk_na_wsk_na_int);
    printf("x = %d\n", ***wsk_na_wsk_na_wsk_na_int);

    printf("\n");

    /*
    [00000001]   x
    |
    [address1]   wsk_na_int
    |
    [address2]   wsk_na_wsk_na_int
    |
    [address3]   wsk_na_wsk_na_wsk_na_int


    [address3] -> [address2] -> [address1] -> [00000001]
                  |             |             |
                  address3      address2      address1
    */

    printf("&x = %p\n", &x);

    printf("\n");

    printf("address1 = %p\n", wsk_na_int);
    printf("address1 = %p\n", *wsk_na_wsk_na_int);
    printf("address1 = %p\n", **wsk_na_wsk_na_wsk_na_int);

    printf("\n");

    printf("address2 = %p\n", wsk_na_wsk_na_int);
    printf("address2 = %p\n", *wsk_na_wsk_na_wsk_na_int);

    printf("\n");

    printf("address3 = %p\n", wsk_na_wsk_na_wsk_na_int);

    /*
    [address3] -> [address2] -> [address1] -> [00000001]
                  |             |             |
                  address3      address2      address1


    [0022FEB0] -> [0022FEB4] -> [0022FEB8] -> [00000001]
                  |             |             |
                  0022FEB0      0022FEB4      0022FEB8
    */

    return 0;
}

