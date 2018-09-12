/*
  client to test listIteratorInt.
  Written by ....
*/

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <string.h>
#include "listIteratorInt.h"


int main(int argc, char *argv[])
{
	IteratorInt l = IteratorIntNew();
	int a = add(l, 20);
	a = add(l, 45);
	a = add(l, 55);
	a = add(l, 66);
	printf("%d\n", a);
	int b = *findPrevious(l, 66);
	printf("%d\n", b);
	reset(l);
	b = *findNext(l, 55);
	printf("%d\n", b);

  return EXIT_SUCCESS;

}
