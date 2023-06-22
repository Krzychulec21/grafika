#include <stdio.h>

/*

r1  r2  r3
|---|---|       
1   2   3   4   5   6   7    indeksy
3   4   8   12  22 35   61   wartoœci
    |---|---|
    r1  r2  r3

Przesuniêcie ramki w prawo:

r1 = r2
r2 = r3
r3 = 0.5*r2 + 2*r1

*/

int seq1(int n) {
	int r1 = 3;
    int r2 = 4;
    int r3 = 8;
    
    if (n == 1) return r1;
    if (n == 2) return r2;
    if (n == 3) return r3;
    
    int i;
    for (i = 1; i <= n-3; i++) {
        r1 = r2;
        r2 = r3;
        r3 = 0.5*r2 + 2*r1;
    }
    
    return r3;
}

/*
- ile razy nale¿y przesun¹æ ramkê w prawo, 
  aby wyznaczyæ wartoœæ n-tego wyrazu ci¹gu w funkcji seq dla n >= 3 ?
  
  Nale¿y przesun¹æ j¹ n-3 razy w prawo
*/

/*
- dokonaj analizy wywo³ania seq1(4)

*seq1(4) = 12
	r1 = 3
	r2 = 4
	r3 = 8
	
	4 == 1  false
	4 == 2  false
	4 == 3  false
	
	i
	i = 1
	1 <= 1 r1 = 4
		   r2 = 8
		   r3 = 0.5*8 + 2*4 = 12   i = 2
	2 <= 1 false
	
	return r3 = 12
*/

/*
- narysuj graf obliczen dla fibo1(4)

seq(0) seq(1)   seq(2)
        \   /   |
       seq(3)   |
            \   |
            seq(4)  
*/

int seq2(int n) {
	int r1 = 3;
    int r2 = 4;
    
    if (n == 1) return r1;
    if (n == 2) return r2;
    
    int i;
    for (i = 1; i <= n-2; i++) {
        int pom = r1;
        r1 = r2;
        r2 = 0.5*r2 + 2*pom;
    }
    
    return r2;
}

/*
- ile razy nale¿y przesun¹æ ramkê w prawo, 
  aby wyznaczyæ wartoœæ n-tego wyrazu ci¹gu w funkcji seq dla n >= 2 ?
  
  Nale¿y przesun¹æ j¹ n-2 razy w prawo
*/

/*
- dokonaj analizy wywo³ania seq1(4)

*seq2(4) = 12
	r1 = 3
	r2 = 4
	
	4 == 1  false
	4 == 2  false
	
	i
	i = 1
	1 <= 2  pom = 3
		    r1 = 4
		    r2 = 0.5*4 + 2*3 = 8   i = 2
	2 <= 2  pom = 4
			r1 = 8
			r2 = 0.5*8 + 2*4 = 12  i = 3
	3 <= 2  false
	
	return r2 = 12
*/

/*
- narysuj graf obliczen dla fibo2(4)

seq(0)   seq(1)
    \   /  |
  seq(2)  |
    |  \  |
    | seq(3)
    |  /
   seq(4)
*/

/*
- która funkcja ma mniejsz¹ z³o¿onoœæ obliczeniow¹ seq1 czy seq2 ?

seq1
*/

int seq3(int n) {
//	0.5*r2 + 2*r1
	if (n == 1) return 3;
	if (n == 2) return 4;
	
	return 0.5*seq3(n-1) + 2*seq3(n-2);
}

/*
- dokonaj analizy wywo³ania seq3(4)

* seq1(4) = 12
  n = 4
  return 0.5*seq2(3) + 2*seq (2) = 0.5*8 + 2*seq5(2) = 4 + 2*4 = 12
  
* seq2(3) = 8
  n = 3
  return 0.5*seq3(2) + 2*seq (1) = 0.5*4 + 2*seq4(1) = 2 + 2*3 = 8
  
* seq3(2) = 4
  n = 2
  return 4
  
* seq4(1) = 3
  n = 1
  return 3
  
* seq5(2) = 4
  n = 2
  return 4
*/

/*
- narysuj graf wywo³añ dla seq3(4)


*/

int main() {
	printf("sequence.c\n\n");
	
	int n = 4;
    
    printf("seq1(%d) = %d\n", n, seq1(n));
    printf("seq2(%d) = %d\n", n, seq2(n));
    printf("seq3(%d) = %d\n", n, seq3(n));
	
	return 0;
}
