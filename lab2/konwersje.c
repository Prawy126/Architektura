#include <stdio.h>
#include <stdlib.h>

/*
- jaką maksymalną liczbę binarną można zapisać przy pomocy typu int?

UINT_MAX = 4294967295
UBIN_MAX = 1111111111

- jaka jest wartość dziesiętna maksymalnej liczby binarnej, jaką można zapisać przy pomocy typu int?

           9876543210
UBIN_MAX = 1111111111 = 2^10 - 1 = 1023

- dla jakich wartości parametrów aktualnych powyższe funkcje będą działać poprawnie?

Funkcje dec2bin i bin2dec będą działać dla liczb całkowitych ze znakiem, a funkcja dec2byte będzie działać dla liczb całkowitych bez znaku
*/

/*
11 / 2 = 5   r0 = 1
5 / 2 = 2    r1 = 1
2 / 2 = 1    r2 = 0
1 / 2 = 0    r3 = 1

     3210
11 = 1011 = 1*10^0 + 1*10^1 + 0*10^2 + 1*10^3
*/

int dec2bin(int x) {
    int sum = 0;
    int pow = 1;
    
    while (x > 0) {
        sum = sum + x%2 * pow;
        
        x = x / 2;
        pow = pow * 10;
    }
    
    return sum;
}

int bin2dec(int x) {
	int sum = 0;
	int pow = 1;
	
	while(x > 0) {
		sum = sum + x%10 * pow;
		
		x = x / 10;
		pow = pow * 2;
	}
	
	return sum;
}

void dec2byte(unsigned int x) {
	unsigned char bytes[4];
	
	bytes[0] = x % 256;
	bytes[1] = x / 256;
	bytes[2] = x / 65536;
	bytes[3] = x / 16777216;

	/* drugi sposób
    bytes[0] = (unsigned char)(x & 0xFF);         // Najmniej znaczący bajt
    bytes[1] = (unsigned char)((x >> 8) & 0xFF);
    bytes[2] = (unsigned char)((x >> 16) & 0xFF);
    bytes[3] = (unsigned char)((x >> 24) & 0xFF);
	*/

	printf("[");
	for (int i = 0; i < 4; i++) {
		printf("%d", bytes[i]);
		if (i < 3) {
			printf("][");
		}
	}
	printf("]\n");
}

int main() {
    printf("konwersje.c\n\n");
    
    int dec1 = 1023;
    
    printf("dec2bin(%u) = %u\n\n", dec1, dec2bin(dec1));
    
    int dec2 = 1111111111;
    
    printf("bin2dec(%u) = %u\n\n", dec2, bin2dec(dec2));
    printf("dec2byte(%u) = ", dec1);
    dec2byte(dec1);
    
    return 0;
}
