#include <stdio.h>

int seq1(int n) {
    int r1 = 3;
    int r2 = 4;
    int r3 = 8;
    
    if (n == 1) return r1;
    if (n == 2) return r2;
    if (n == 3) return r3;
    
    int i;
    for (i = 1; i <= n-3; i++){
        r1 = r2;
        r2 = r3;
        r3 = 2*r1 + 0.5*r2;
    }
    
    return r3;
}

/*
- dokonaj analizy wywo³ania seq1(4)

* seq1(4) = 5 
  r1 = 3
  r2 = 4
  r3 = 8
  
  4 == 1   false
  4 == 2   false
  4 == 3   false
  
  i
  i = 1
  1 <= 2   r1 = 4
           r2 = 8
           r3 = 4 + 8 = 12   i = 2
  2 < 2   false
  
  return r3 = 12       
*/

/*
- narysuj graf obliczen dla seq1(4)

f(0)  f(1)    f(2)
        \   /  |
         f(3)  |
            \  |
             f(4)
*/


int seq2(int n){
    int r1 = 3;
    int r2 = 4;
    
    if (n == 1) return r1;
    if (n == 2) return r2;
    
    int i;
    for (i = 1; i <= n-2; i++){
        int pom = r1;
        r1 = r2;
        r2 = 2*pom + 0.5*r1;
    }
    
    return r2;
  
}
/*
- dokonaj analizy wywo³ania fibo2(4)

* seq2(4) = 22 
  r1 = 3
  r2 = 4
  
  4 == 1   false
  4 == 2   false

  i
  i = 1
  
  1 <= 3   pom = 3
           r1 = 4
           r2 = 0.5*4 + 2*3 = 8    i = 2
  2 <= 3   pom = 4
           r1 = 8
           r2 = 0.5*8 + 2*4 = 12   i = 3  
  3 < 3   false
 
  return r2 = 12 
*/

/*
- narysuj graf obliczen dla fibo2(4)

f(0)     f(1)
   \   /  |
    f(2)  |
    |  \  |
    |   f(3)
    |  /
    f(4)
 
*/

int seq3(int n) {
    if (n <= 2) {
        return n + 2;
    } else {
        return 0.5 * seq3(n-1) + 2 * seq3(n-2);
    }
}
/*
- dokonaj analizy wywo³ania seq3(4)

* seq1(4) = 12
  return 0.5 * seq2(3) + 2 * seq (2) =  0.5 * seq2(3) + 2 * seq3(2) = 4 + 8 = 12

* seq2(3) = 8
  return 0.5 * seq3(2) + 2 * seq (1) = 0.5 * seq3(2) + 2 * seq4(1) = 2 + 6 = 8

* seq3(2) = 4
  return n + 2 = 2 + 2 = 4

* seq4(1) = 3
  return n + 2 = 1  + 2 = 3

 */
/*
Analiza do seq3
*/
/*
Graf do seq3
 s(1)   s(2)
  \    /   |
   s(3)    |
  /   \    |
s(2)  s(1) |
  \   /   /
   s(3)  /
  /    \/
s(2)  s(3)
  \   /
   s(4)
 */

void indent(int n) {
    int i;
	for (i = 0; i < n; i++) {
        printf("  ");
    }
}

void SequenceTree(int n, int depth) {
    indent(depth);
    printf("seq3(%d)\n", n);

    if (n > 2) {
        SequenceTree(n-1, depth+1);
        SequenceTree(n-2, depth+1);
    }

    indent(depth);
    printf("return seq3(%d) = %d\n", n, seq3(n));
}


int main(){
    printf("sequence.c\n\n");
    
    int n = 4;
    
    printf("seq1(%d) = %d\n", n, seq1(n));
    printf("seq2(%d) = %d\n", n, seq2(n));
    printf("seq3(%d) = %d\n", n, seq3(n));

    printf("SequenceTree for seq3(%d):\n", n);
    SequenceTree(n, 0);
    
    return 0;
}
