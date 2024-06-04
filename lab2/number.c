#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/*zadanie domowe implementacje funkcji horner i reprezentacje 1 i 2-u bajtowe*/

int polinomial(unsigned char *p, int n) {
	unsigned int suma = 0;
	
	int i;
	for (i = 0; i < n; i++) {
		suma = suma + *(p + i) * pow(256, i);
	}
	
	return suma;
}

int horner(unsigned char *p, int n) {
	unsigned int dlugosc = sizeof(p) / 4 - 1;
	unsigned int suma = p[dlugosc];
	
	for (int i = dlugosc - 2; i >= 0; i--) {
		suma = p[i] + i * suma;
	}
	
	return suma;
}

int main() {
    printf("number.c\n\n");
    
    char x[] = {4, 1, 0, 0};
    
    int n = sizeof(x);
    
    printf("number(%p, %u) = %u\n\n", x, n, polinomial(x, n));
    printf("horner(%p, %u) = %u\n", x, n, polinomial(x, n));
    
    return 0;
}
