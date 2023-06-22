#include <stdio.h>

int main() {
	printf("endian2.c\n\n");
	
	int x = 0x53000020;
	char *p = (char*)&x;

	// 0x20 = 32
	if(*p == 0x20) {
		printf("little-endian architecture");
	} else {
		printf("big-endian architecture");
	}
	
	return 0;
}
