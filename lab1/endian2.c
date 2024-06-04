#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("endian2.c\n\n");
    
    short x = 1;
    char *b = (char*)&x;
    
    if (*b == 1) {
    	printf("little-endian architecture.\n");
	}
	else if (*b == 0) {
		printf("big-endian architecture.\n");
	}
    
    return 0;
}
