#include <stdio.h>

int main() {
	printf("mul2.c\n\n");
	
	unsigned int a = 4294967295u;
	unsigned int b = 2;
	
	unsigned long long iloczyn = (unsigned long long)a * (unsigned long long)b;
	
	printf("a = %u\n", a);
    printf("b = %u\n", b);
    
    printf("iloczyn = %llu", iloczyn);
}
