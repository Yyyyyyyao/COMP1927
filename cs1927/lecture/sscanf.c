#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv){

	int n;
	//if(sscanf(argv[1], "%d", &n) == 1){
	//}
	printf("count is %d\n", sscanf(argv[1], "%d", &n));
	printf("n is %d\n", n);

	exit(EXIT_SUCCESS);

   // sscanf will return 1 if argv[] corespond with %d otherwise return 0
}
