#include <stdio.h>

int main() {
	printf("add4.c\n\n");
	
	int a = -2147483648;
	int b = -1;
	
	long long suma = (long long)a + (long long)b;
	
	printf("a = %d\n", a);
	printf("b = %d\n\n", b);
	printf("suma = %lld", suma);
}
