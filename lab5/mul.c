#include <stdio.h>

int main(){
    printf("mul.c\n\n");
    
    unsigned int a = 4294967295u;
    unsigned int b = 2;
    
    unsigned int iloczyn = a*b;
    
    printf("a = %u\n", a);
    printf("b = %u\n", b);
    
    printf("iloczyn = %u\n", iloczyn);
    
    return 0;
}
