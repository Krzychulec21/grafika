#include <stdio.h>

int main() {
	printf("data.c\n\n");
	
	int a, b, c, d, e, f, g, h;
	
	printf("&a = %p\n", &a);
	printf("&b = %p\n", &b);
	printf("&c = %p\n", &c);
	printf("&d = %p\n", &d);
	printf("&e = %p\n", &e);
	printf("&f = %p\n", &f);
	printf("&g = %p\n", &g);
	printf("&h = %p\n", &h);
	
	a = 1;
	b = 2;
	
	e = 3;
	h = 4;
	
	/*
	
	0061FE9C [1][0][0][0]   a
	0061FE98 [2][0][0][0]   b
	0061FE94 [ ][ ][ ][ ]   c
	0061FE90 [ ][ ][ ][ ]   d                     
	0061FE8C [3][0][0][0]   e	
	0061FE88 [ ][ ][ ][ ]   f
	0061FE84 [ ][ ][ ][ ]   g
	0061FE80 [4][0][0][0]   h

	Tak, adresy s¹ zgodne z map¹ pamiêci. 
	*/
	
	return 0;
}
