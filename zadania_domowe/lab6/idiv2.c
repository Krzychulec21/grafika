#include <stdio.h>

int main() {
	printf("idiv2.c\n\n");
	
	long long a = -2147483650;
	int b = -3;
		
	printf("a = %lld\n", a);
	printf("b = %d\n\n", b);
	
	int iloraz = a / b;
	int reszta = a % b;
	
	printf("iloraz = %lld\n", iloraz);
	printf("reszta = %lld", reszta);
	
	return 0;
}
