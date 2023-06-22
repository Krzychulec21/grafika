#include <stdio.h>

int main() {
	printf("div2.c\n\n");
	
	unsigned long long a = 4294967296;
	unsigned int b = 3;
	
	unsigned long long iloraz = a / b;
	unsigned int reszta = a % b;
	
	printf("a = %llu\n", a);
	printf("b = %u\n\n", b);
	printf("iloraz = %llu\n", iloraz);
	printf("reszta = %u", reszta);
	
	return 0;
}
