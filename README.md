# Architekura systmów komputerowych
## LAB 1

#### Zadanie 1
Napisz program size sprawdzający, ile bajtów zajmują typy: char, short, int, long, long int, long long oraz float, double, long double.

[wikipedia](https://en.wikipedia.org/wiki/C_data_types)

- Rozwiązadnie(kod):

```c
#include<stdio.h>
#include<stdlib.h>

int main(){
    printf("size.c\n\n");
    
    
    printf("sizeof(char) = %lu\n", sizeof(char));
    printf("sizeof(short) = %lu\n", sizeof(short));
    printf("sizeof(int) = %lu\n", sizeof(int));
    printf("sizeof(long) = %lu\n", sizeof(long));
    printf("sizeof(long int) = %lu\n", sizeof(long int));
    printf("sizeof(long long) = %lu\n", sizeof(long long));
    
    printf("\n");
    
    printf("sizeof(float) = %lu\n", sizeof(float));
    printf("sizeof(double) = %lu\n", sizeof(double));  
    printf("sizeof(long double) = %lu\n", sizeof(long double));    
    
    
    
    return 0;
}
```

#### Zadanie 2
Napisz program size2 sprawdzający, ile bajtów zajmują typy: char, short, int, long, long int i long long bez znaku.

- Rozwiązanie(kod):

```c
#include<stdio.h>
#include<stdlib.h>
//zadanie domowe
int main(){
    printf("size.c\n\n");
    
    
    printf("sizeof(char) = %lu\n", sizeof(unsigned char));
    printf("sizeof(short) = %lu\n", sizeof(unsigned short));
    printf("sizeof(int) = %lu\n", sizeof(unsigned int));
    printf("sizeof(long) = %lu\n", sizeof(unsigned long));
    printf("sizeof(long int) = %lu\n", sizeof(unsigned long int));
    printf("sizeof(long long) = %lu\n", sizeof(unsigned long long));
    
    return 0;
}
```

#### Zadanie 3

Która z poniższych odpowiedzi jest prawdziwa:

- [x] system 32 bitowy pozwala na uruchamianie programu 32 bitowego 
- [x] system 32 bitowy pozwala na uruchamianie programu 64 bitowego 
- [x] system 64 bitowy pozwala na uruchamianie programu 32 bitowego 
- [x] system 64 bitowy pozwala na uruchamianie programu 64 bitowego 

#### Zadanie 4
Która z poniższych odpowiedzi jest fałszywa:

- [ ] na systemie 32 bitowym można skompilować program do kodu 32 bitowego
- [ ] na systemie 32 bitowym można skompilować program do kodu 64 bitowego
- [ ] na systemie 64 bitowym można skompilować program do kodu 32 bitowego
- [ ] na systemie 64 bitowym można skompilować program do kodu 64 bitowego

#### Zadanie 5
- ile bajtów zajmują adresy w kodzie 32 bitowym? **Adresy  zajmują 32 bity, co oznacza, że można zareprezentować około  2^32^**
- ile bajtów zajmują adresy w kodzie 64 bitowym? **Adresy  zajmują 64 bity, co oznacza, że można zareprezentować około  2^64^**

#### Zadanie 6
Jaki obszar pamięci można zaadresować przy pomocy adresów 16, 20, 24, 32, 40, 48 i 64 bitowych? **2^16^ 2^20^ 2^24^ 2^32^ 2^40^ 2^64^**

#### Zadanie 7

Napisz program bits rozpoznający do ilu bitowego kodu został skompilowany.

```c
#include<stdio.h>
#include<stdlib.h>

int main(){
    printf("bits.c\n\n");
    
    void *p;
    
    size_t bytes = sizeof(p);
    
    printf("sizeof(p) = %lu\n\n", bytes);
    
    if (bytes == 4) printf("I am a 32-bit program.\n");
    
    if (bytes == 8) printf("I am a 64-bit program.\n");
    
    return 0;
}
```

#### Zadanie 8
Załóżmy, że typ int zajmuje 4 bajty. Na ile sposobów można umieścić w pamięci pod adresem p wartość 1 typu int? Zadanie rozwiąż w pliku sposoby.txt.

p -> [ ][ ][ ][ ]   *p = 1
- Rozwiązanie:

p -> [ ][ ][ ][ ]   *p = 1

p -> [1][ ][ ][ ]   *p = 1
p -> [ ][1][ ][ ]   *p = 1
p -> [ ][ ][1][ ]   *p = 1
p -> [ ][ ][ ][1] 

#### Zadanie 9
Procesory w architekturze little-endian zapisują dane w pamięci od lewej do prawej zaczynając od najmłodszego bajtu (LSB – least significant byte). Procesory w architekturze big-endian zapisują dane w pamięci od lewej do prawej zaczynając od najstarszego bajtu (MSB – most significant byte).  Załóżmy, że pod adresem p znajduje się liczba 5 typu int. W pliku endian.txt wypełnij komórki pamięci odpowiednimi wartościami dla obu architektur.

little-endian

p -> [ ][ ][ ][ ]   *p = 5

big-endian

p -> [ ][ ][ ][ ]   *p = 5

- Rozwniązanie:

**Little-endian**
p -> [5][0][0][0]   *p = 5

**Big-endian**
p -> [0][0][0][5]   *p = 5

#### Zadanie 10
W pliku szereg.txt rozwiń w szereg i wyznacz wartości dziesiętne dla liczb: 

1011          – liczba binarna
8732          – liczba dziesiętna
[2][2][1][1]  - reprezentacja little-endian

1234  - liczba ósemkowa *
3A5B  – liczba szesnastkowa *

1011          - liczba binarna
8732          - liczba dziesiętna
[2][2][1][1]  - reprezentacja little-endian

3210 
1011 - 1* 2^0^ + 1 * 2^1^ + 0 * 2^2^ + 1 * 2^3^ = 1 + 2 + 0 + 8 = 11

3210
8723 = 3 * 10^0^ + 3 * 10^1^ + 7 * 10^2^ + 8*10^3^ = 3 + 20 + 700 + 8000

 0  1  2  3     
[2][2][1][1] = 2 * 256^0^ + 2 * 256^1^ + 1 * 256^2^ + 1 * 256^3^= 2 + 512 + 65536

3210
1234 = 4 * 8^0^ + 3* 8^1^ + 2 * 8^2^ + 1 * 8^3^ = 4 + 24 + 128 +  512 = 668

3210
3A5B = 11 * 16^0 + 5 * 16^1^ + 10 * 16^2^ + 3 * 16^3^ = 11 + 80 + 2560 + 12288 = 14939  

#### Zadanie 11
Załóżmy, że pod adresem p znajduje się liczba 260 typu int. Wypełnij komórki pamięci odpowiednimi wartościami dla obu architektur. Zadanie rozwiąż w pliku 260.txt.

- Rozwiązanie:

little-endian

p -> [4][1][0][0]   *p = 260

**big-endian**

p -> [0][0][1][4]   *p = 260

260 = 256 + 4 = 4 + 256 = 4 * 256^0^ + 1 * 256^1^ + 0 * 256^2^ + 0*256^3^ 

#### Zadanie 12
Napisz program bytes wypisujący reprezentację bajtową dla podanej liczby x typu int. Przykładowa sesja:

value = 260

bytes = 004 001 000 000

- Rozwiązanie(Kod):

```c
#include<stdio.h>
#include<stdlib.h>

int main(){
    printf("bits.c\n\n");
    
    void *p;
    
    size_t bytes = sizeof(p);
    
    printf("sizeof(p) = %lu\n\n", bytes);
    
    if (bytes == 4) printf("I am a 32-bit program.\n");
    
    if (bytes == 8) printf("I am a 64-bit program.\n");
    
    return 0;
}
```

#### Zadanie 13
Sprawdź na terminalu Linux w jakiej architekturze pracuje twój procesor.

- Rozwiązanie:
wpisać komendę: `uname -m`

#### Zadanie 14
Napisz program endian rozpoznający w jakiej architekturze pracuje procesor.

- Rozwiązanie(Kod):

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("endian.c\n\n");
    
    printf("sizeof(char) = %u\n",sizeof(char));
    printf("sizeof(short) = %u\n\n",sizeof(short));
    
    short x = 1;
    
    short *w = &x; // w to wska�nik na short (word) 
    
    printf("*w = %d\n\n", *w);
    
    char *b = (char*)&x; // b to wska�nik na char (byte)
    
    // wska�niki w i b przechowuj� ten sam adres 
    
    printf("w = %p\n", *w);
    printf("b = %p\n\n", *b);
    
    // Test Architektury
    
    printf("*b = %d\n", *b);
    printf("*(b+1) = %d\n", *(b+1));

    /*
    - little endian

    w     w+1
    |     |        wskazniki na short (word)
    [1][0][m][s]
    |  |           wskazniki na char (byte)
    b  b+1

    w -> [1][0]  *w = 1

    b   -> [1]   *b     = 1
    b+1 -> [0]   *(b+1) = 0

    - big endian

    w     w+1
    |     |        wskazniki na short (word)
    [0][1][s][m]
    |  |           wskazniki na char (byte)
    b  b+1

    w -> [0][1]   *w = 1

    b   -> [0]    *b     = 0
    b+1 -> [1]    *(b+1) = 1
    */
    
    return 0;
}
```

#### Zadanie 15
Napisz program endian2 wypisujący little-endian architecture lub big-endian architecture w zależności od architektury, w której pracuje procesor.

- Rozwiązanie(Kod):

```c
#include <stdio.h>

int main() {
    unsigned int x = 1;
    char *c = (char*)&x;
    
    if (*c) {
        printf("Little-endian architecture\n");
    } else {
        printf("Big-endian architecture\n");
    }
    
    return 0;
}
```
## Lab 2

#### Zadanie 1
Napisz program stack umieszczający na stosie kolejno dwie zmienne x i y typu int z wartościami 1 i 2 oraz odczytaj adresy tych zmiennych. Skopiuj poniższy schemat do komentarza w programie i wypełnij go odpowiednimi wartościami. 

&var1 [ ][ ][ ][ ]   var1
&var2 [ ][ ][ ][ ]   var2

Czy adresy zmiennych są zgodne z mapą pamięci dla procesu?

- Program:

```c
#include<stdio.h>
#include<stdlib.h>

int main(){
    printf("heap.c\n\n");
    
    void* x = malloc(sizeof(int));
    void* y = malloc(sizeof(int));
    
    printf("x = %p\n",x);
    printf("y = %p\n\n",y);
    
    printf("y - x = %d\n\n", (y-x));
    
    *(int*)x = 1;
    *(int*)y = 2;
    
    printf("x = %d\n", *(int*)x);
    printf("y = %d\n", *(int*)y);
    
    /*
    

          [ ][ ][ ][ ]
          [ ][ ][ ][ ]
          [ ][ ][ ][ ]
00C01620  [2][0][0][0]   *y

          [ ][ ][ ][ ]
          [ ][ ][ ][ ]
          [ ][ ][ ][ ]
00C01610  [1][0][0][0]   *x

    */
    
    return 0;
}

```

#### Zadanie 2
Napisz program stack umieszczający na stosie kolejno dwie zmienne x i y typu int z wartościami 1 i 2 oraz odczytaj adresy tych zmiennych. Skopiuj poniższy schemat do komentarza w programie i wypełnij go odpowiednimi wartościami. 

&var1 [ ][ ][ ][ ]   var1
&var2 [ ][ ][ ][ ]   var2

Czy adresy zmiennych są zgodne z mapą pamięci dla procesu?

Zad. 2.2 *

W programie data umieść w sekcji danych kolejno zmienne a, b, c, d, e, f, g, h typu int oraz odczytaj adresy tych zmiennych. Do zmiennych zainicjowanych podstaw kolejne liczby naturalne od 1 do 4. Rozpatrz następujące przypadki:

- zmienne a i b są zainicjowane
- zmienne c i d są niezainicjowane
- zmienna e jest zainicjowana i zmienna f jest niezainicjowana
- zmienna g jest niezainicjowana i zmienna h jest zainicjowana

Skopiuj poniższy schemat do komentarza w programie oraz wypełnij go odpowiednimi wartościami.

&var1 [ ][ ][ ][ ]   var1
&var2 [ ][ ][ ][ ]   var2
&var3 [ ][ ][ ][ ]   var3
&var4 [ ][ ][ ][ ]   var4
                         
&var5 [ ][ ][ ][ ]   var5	
&var6 [ ][ ][ ][ ]   var6
&var7 [ ][ ][ ][ ]   var7
&var8 [ ][ ][ ][ ]   var8

Czy adresy zmiennych są zgodne z mapą pamięci dla procesu?

- Rozwiązanie:

```c
#include <stdio.h>

int main() {
    int a = 1, b = 2;
    int c, d;
    int e = 3, f;
    int g, h = 4;

    printf("&var1 [%p]   var1\n", (void*)&a);
    printf("&var2 [%p]   var2\n", (void*)&b);
    printf("&var3 [%p]   var3\n", (void*)&c);
    printf("&var4 [%p]   var4\n", (void*)&d);
    printf("\n");
    printf("&var5 [%p]   var5\n", (void*)&e);
    printf("&var6 [%p]   var6\n", (void*)&f);
    printf("&var7 [%p]   var7\n", (void*)&g);
    printf("&var8 [%p]   var8\n", (void*)&h);

    return 0;
}

```

#### Zadanie 3
W programie heap umieść na stercie dwie liczby 1 i 2 typu int. Adresy tych liczb zapisz w zmiennych odpowiednio x i y. Wypisz te adresy oraz wartości, które się pod nimi znajdują. Oblicz rozmiar przydzielonego obszaru pamięci. Skopiuj poniższy schemat do komentarza w programie i wypełnij go odpowiednimi wartościami.

     [ ][ ][ ][ ]
     [ ][ ][ ][ ]
     [ ][ ][ ][ ]
var1 [ ][ ][ ][ ]   *var1

     [ ][ ][ ][ ]
     [ ][ ][ ][ ]
     [ ][ ][ ][ ]
var2 [ ][ ][ ][ ]   *var2

1.Czy do wskaźnika typu void* można stosować operator wyłuskania?

2.Ile razy należy wywołać funkcję malloc, aby obliczyć rozmiar przydzielonego obszaru pamięci?

3.Czy adresy liczb są zgodne z mapą pamięci dla procesu?

4.Jaki najmniejszy obszar pamięci przydziela na stercie system operacyjny dla kodu 32 i 64 bitowego?

- Rozwiązanie kod:

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("heap.c\n\n");
    
    void* x = malloc(sizeof(int));
    void* y = malloc(sizeof(int));
    
    printf("x = %p\n", x);
    printf("y = %p\n\n", y);
    
    printf("y - x = %d\n\n", y - x);
 
    *(int*)x = 1;
    *(int*)y = 2;
    
    printf("*x = %d\n", *(int*)x);
    printf("*y = %d\n", *(int*)y);
    
    /*
         [ ][ ][ ][ ]   
         [ ][ ][ ][ ]   
         [ ][ ][ ][ ]   
00A71640 [2][0][0][0]  *y
                             
         [ ][ ][ ][ ]   	
         [ ][ ][ ][ ]   
         [ ][ ][ ][ ]   
00A71630 [1][0][0][0]  *x
    */
    
    return 0;
}

```

- Odpowiedź:
1.Nie, do wskaźnika typu void* nie można stosować operatora wyłuskania.
2.Funkcję malloc należy wywołać tylko raz, aby przydzielić pamięć.
3.Adresy liczb mogą nie być zgodne z mapą pamięci dla procesu.
4.Najmniejszy obszar pamięci przydzielany na stercie to kilka kilobajtów dla kodu 32-bitowego i kilkadziesiąt kilobajtów dla kodu 64-bitowego.

#### Zadanie 4
W pliku konwersje.txt dokonaj konwersji liczb:

- dziesiętne 11 na liczbę binarną
- dziesiętne 99 na liczbę binarną *
- szesnastkowe 10AF na liczbę binarną
- szesnastkowe 3A58 na liczbę binarną *
###### Odpowiedź:
11 / 2 = 5   r0 = 1
5 / 2 = 2    r1 = 1
2 / 2 = 1    r2 = 0
1 / 2 = 0    r3 = 1

11(10) = 1011(2)

 8  4  2  1
[ ][ ][ ][ ]

10AF = 0001 0000 1010 1111

#### Zadanie 5
Napisz program konwersje implementujący następujące funkcje:

int dec2bin(int x);
int bin2dec(int x); // *
void dec2byte(unsigned int x); // reprezentacja little-endian *

- jaką maksymalną liczbę binarną można zapisać przy pomocy typu int?

- jaka jest wartość dziesiętna maksymalnej liczby binarnej, jaką można zapisać przy pomocy typu int?

- dla jakich wartości parametrów aktualnych powyższe funkcje będą działać poprawnie?

###### Odpowiedź 

```c
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int polinomial(unsigned char *p, int n){
	unsigned int suma = 0;
	
	int i;
	for( i = 0; i < n; i++){
		suma = suma + *(p + i) * pow(256,i);
	}
	return suma;
	
}

int main() {
    printf("number.c\n\n");
    
    char x[] = {4, 1, 0, 0};
    
    int n = sizeof(x);
    
    printf("number(%p, %u) = %u\n",x,n,polinomial(x,n));
    
    return 0;
}

```
- odpowiedź:

Maksymalna liczba binarna w typie int: 2147483647 (w zakresie typu int).

Wartość dziesiętna maksymalnej liczby binarnej w typie int: 2147483647.

Funkcje będą działać poprawnie dla wartości nieujemnych.

Przykładowa sesja:

dec2bin(1023) = 1111111111

bin2dec(1111111111) = 1023

dec2byte(1023) = [255][003][000][000]


#### Zadanie 6
Napisz program number wyliczający wartość liczby bez znaku na podstawie jej n bajtowej reprezentacji pod adresem p przy pomocy funkcji:

- funkcja polinomial wylicza wartość wielomianu w sposób klasyczny

int polinomial(unsigned char *p, int n);

- funkcja horner wylicza wartość wielomianu schematem Hornera *

int horner(unsigned char *p, int n);

Przetestuj funkcje dla reprezentacji jedno, dwu i czterobajtowych. Reprezentację liczby należy określić przy pomocy tablicy typu char. Wskazówka:

http://www.balois.pl/java/proste/wielomiany.htm

Przykładowa sesja:

number(0061FE94, 4) = 16711680
number(0061FE94, 4) = 16711680

- Rozwiązanie:

```c
#include <stdio.h>

// Funkcja wyliczająca wartość wielomianu w sposób klasyczny
int polinomial(unsigned char *p, int n) {
    int result = 0;
    int i;
    for (i = 0; i < n; i++) {
        result += p[i] << (8 * i);
    }
    return result;
}

// Funkcja wyliczająca wartość wielomianu schematem Hornera
int horner(unsigned char *p, int n) {
    int result = 0;
    int i;
    for (i = n - 1; i >= 0; i--) {
        result = (result << 8) | p[i];
    }
    return result;
}

int main() {
    unsigned char number1[] = {0x00, 0x00, 0x01, 0x00}; // 4 bajty, liczba 256
    unsigned char number2[] = {0x00, 0x00, 0xFF};       // 3 bajty, liczba 255

    printf("number(0x0061FE94, 4) = %d\n", polinomial(number1, 4));
    printf("number(0x0061FE94, 4) = %d\n", horner(number1, 4));

    printf("number(0x0061FE94, 3) = %d\n", polinomial(number2, 3));
    printf("number(0x0061FE94, 3) = %d\n", horner(number2, 3));

    return 0;
}

```

