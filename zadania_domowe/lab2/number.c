#include <stdio.h>
#include <math.h>

/*
 0  1  2  3 
[1][0][5][1] = 1 * 256^0 + 0 * 256^1 + 5 * 256^2 + 1 * 256^3 =     

*/

int polinomial(unsigned char *p, int n) {
    unsigned int sum = 0;
    
    int i;
    for (i = 0; i < n; i++) {
        sum += *(p + i) * pow(256, i);
    }
    
    return sum;
}

int horner(unsigned char *p, int n) {
	unsigned int sum = *p; 
	
	int i;
	for (i = 1; i < n; i++) {
		sum = sum * 256 + *(p + i);
	}
	
	return sum;
}

int main() {
    printf("number.c\n\n");
    
    unsigned char tab[] = {255, 255, 255, 255};
    int n = sizeof(tab);
    
    printf("polinomial(%p, %d) = %u\n", tab, n, polinomial(tab, n));
    printf("horner(%p, %d) = %u\n", tab, n, horner(tab, n));
    
    return 0;
}
