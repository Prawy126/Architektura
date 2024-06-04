#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("data.c\n\n");
    
    int a = 1;
    int b = 2;
    int c;
    int d;
    int e = 3;
    int f;
    int g;
    int h = 4;
    
    printf("p_a = %p\n", &a);
    printf("p_b = %p\n", &b);
    printf("p_c = %p\n", &c);
    printf("p_d = %p\n", &d);
    printf("p_e = %p\n", &e);
    printf("p_f = %p\n", &f);
    printf("p_g = %p\n", &g);
    printf("p_h = %p\n", &h);
    
    /*
    000000000065FE1C [1][ ][ ][ ]   a
	000000000065FE18 [2][ ][ ][ ]   b
	000000000065FE14 [ ][ ][ ][ ]   c
	000000000065FE10 [ ][ ][ ][ ]   d
	                         
	000000000065FE0C [3][ ][ ][ ]   e	
	000000000065FE08 [ ][ ][ ][ ]   f
	000000000065FE04 [ ][ ][ ][ ]   g
	000000000065FE00 [4][ ][ ][ ]   h
    */
    
    return 0;
}
