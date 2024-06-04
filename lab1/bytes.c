#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("bytes.c\n\n");
    
    int x = 260;
    
    printf("value = %d\n\n", x);
    
    unsigned char *p = (unsigned char*)&x;
    
    printf("bytes = %.3d %.3d %.3d %.3d\n", *p, *(p+1), *(p+2), *(p+3));
        
    return 0;
}
