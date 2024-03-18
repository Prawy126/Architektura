# Architekura systmów komputerowych
## LAB 1

#### Zadanie 1
Napisz program size sprawdzający, ile bajtów zajmują typy: char, short, int, long, long int, long long oraz float, double, long double.

[wikipedia](https://en.wikipedia.org/wiki/C_data_types)

- Rozwiązadnie(kod):

```C
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

```C
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

```C
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

```C
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

```C
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

```C
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


