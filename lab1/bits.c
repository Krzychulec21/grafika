#include <stdio.h>

int main() {
    printf("bits.c\n\n");
    
    void *p;
    
    size_t bytes = sizeof(p);
    
    printf("sizeof(p) = %d\n\n", bytes);
    
    if (bytes == 4) printf("I'm 32 bit program.\n");
    
    if (bytes == 8) printf("I'm 64 bit program.\n");
    
    return 0;
}
