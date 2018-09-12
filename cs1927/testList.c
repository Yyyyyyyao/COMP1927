#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include "list.h"

// insert proper tests here
int main (int argc, const char * argv[]) {
  printf("Write your tests here!\n");
  printf("Remember to consider boundary/edge cases as well as typical use cases!\n");

  link i = fromTo(0,10);
  // do some tests
  printf("List i: ");
  printList(i);
  printf("\n");

  i = deleteEven(i);
  printList(i);

  return EXIT_SUCCESS;;
}
