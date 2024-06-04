#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("stack.c\n\n");
    
    int x = 1;
    int y = 2;
    
    int *p_x = &x;
    int *p_y = &y;
    
    printf("p_x = %p\n", p_x);
    printf("p_y = %p\n", p_y);
    
    /*
    0061FE94 [1][0][0][0]   x
    0061FE90 [2][0][0][0]   y
    */
    
    return 0;
}
