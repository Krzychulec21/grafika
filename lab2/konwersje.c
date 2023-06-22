#include <stdio.h>

/*

- jak¹ maksymaln¹ liczbê binarn¹ mo¿na zapisaæ przy pomocy typu int?

UINT_MAX = 4294967295
INT_MAX  = 2147483647
UBIN_MAX = 1111111111

Odp: 1111111111

- jaka jest wartoœæ dziesiêtna maksymalnej liczby binarnej, jak¹ mo¿na zapisaæ przy pomocy typu int?

           9876543210
UBIN_MAX = 1111111111

Odp: (2^10) - 1 = 1023

- dla jakich wartoœci parametrów aktualnych powy¿sze funkcje bêd¹ dzia³aæ poprawnie?

Odp: 0..1023

*/


/*

11 / 2 = 5   r0 = 1
5 / 2 = 2    r1 = 1
2 / 2 = 1    r3 = 0
1 / 2 = 0    r4 = 1

11 = 1011 = 1 * 10^0 + 1 * 10^1 + 0 * 10^2 + 1 * 10^3 = 1011

*/

int dec2bin(int x) {
    int sum = 0;
    int pow = 1; // 10^0 = 1
    
    while (x > 0) {
        sum += (x % 2) * pow;
        
        x /= 2;
        
        pow *= 10;
    }
    
    return sum;
}

int bin2dec(int x) {
    int sum = 0;
    int pow = 1; // 2^0 = 1
    
    while (x > 0) {
    	sum += (x % 10) * pow;
    	
    	x /= 10;
    	
    	pow *= 2;
	}
    
    return sum;
}

void dec2byte(unsigned int x) {
    unsigned char *p = (char*)&x;
    
    printf("[%03d] [%03d] [%03d] [%03d]", *p, *(p+1), *(p+2), *(p+3));
}

int main() {
    printf("konwersje.c\n\n");
    
    int dec1 = 11; // dec1 = 0..1023
    
    printf("dec2bin(%d) = %d\n", dec1, dec2bin(dec1));
    
    int bin = 1111111111;

	printf("bin2dec(%d) = %d\n", bin, bin2dec(bin));
	
	int dec2 = 1023;
    
    printf("dec2byte(%d) = ", dec2);
    dec2byte(dec2);
    
    return 0;
}
