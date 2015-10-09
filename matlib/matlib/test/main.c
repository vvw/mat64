
#include "stdio.h"
#include "mcadd.h"

#pragma comment(lib, "../bin/matlib.lib")
#pragma comment(lib, "mcadd.lib")


int add(int a, int b);

int main() {
	printf("hi,,, %d %d\n", add(1, 2), mcadd(3, 4));
	getchar();
	return 0;
}

