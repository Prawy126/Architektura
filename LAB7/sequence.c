#include <stdio.h>
#include <stdlib.h>

/*
seq0 	seq1    seq2
|-------|-------|       
0   	1     	2   	3   	4   	5   	6    indeksy
3		3		4		8		12		22		??   wartości
    	|-------|-------|
      seq0    seq1    seq2

Przesunięcie ramki w prawo:

seq0 = seq1
seq1 = seq2
seq2 = seq1 + seq0

- ile razy należy przesunąć ramkę w prawo, aby wyznaczyć wartość n-tego wyrazu ciągu w funkcji seq dla n >= 3 ?
należy dokonać n-2 przejść
*/

int seq1(int n) {
	int seq1 = 3;
	int seq2 = 4;
	
	if (n == 1) return seq1;
	if (n == 2) return seq2;
	
	int i;
	for (i = 1; i <= n-2; i++) {
		int seq0 = seq1;
		seq1 = seq2;
		seq2 = 2*seq0 + 0.5*seq1;
	}
	
	return seq2;
}
/*
- dokonaj analizy wywołania seq1(4)

* seq1(4) =
  seq0 = 3
  seq1 = 3
  seq2 = 4
  
4 == 0  false 
4 == 1  false
4 == 2  false

i
i = 2
2 < 4   seq0 = 3
        seq1 = 4
        seq2 = 0.5*seq1 + 2*seq0 = 8 i = 3

3 < 4   seq0 = 4
		seq1 = 8
		seq2 = 0.5*seq1 + 2*seq0 = 12 i = 4

4 <  4 	false

return seq2 = 12  

- narysuj graf obliczeń dla seq1(4)

seq(0)    seq(1)  seq(2)
            \    /   |
            seq(3)   |
               \     |
                seq(4)  
*/

int main() {
    printf("sequence.c\n\n");
    
    int n = 5;
    
    printf("seq1(%d) = %d\n", n, seq1(n));
    
    return 0;
}