// testList.c - testing DLList data type
// Written by John Shepherd, March 2013

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "DLList.h"



int main(int argc, char *argv[])
{
	
    printf("**********Testing DLListBefore*************\n");
    printf("\n");


    DLList myList;
    myList = getDLList(stdin);
	

    
    printf("TEST 1: Add in an empty list\n");
    printf("\n");
    printf("**********Before Operation*****************\n");
    printf("curr is NULL\n");
    printf("nitems is %d\n", DLListLength(myList));
    printf("Condition: %d item in list\n", DLListLength(myList));
    printf("\n");

    printf("**********After Operation******************\n");
    printf("**********Input****************************\n");
    printf("first line\n");
    printf("**********Output***************************\n");
    DLListBefore(myList, "first line");
    showDLList(stdout,myList);
    printf("nitems is %d\n", DLListLength(myList));
    printf("curr is %s\n", DLListCurrent(myList));
    printf("Condition: %d item in list\n", DLListLength(myList));
    assert(validDLList(myList));

    printf("\n");
    printf("\n");

    printf("TEST 2: Add before the first or last one\n");
    printf("\n");
    printf("**********Before Operation*****************\n");
    printf("curr is %s\n", DLListCurrent(myList));
    printf("nitems is %d\n", DLListLength(myList));
    printf("Condition: %d item in list\n", DLListLength(myList));
    printf("\n");

    printf("**********After Operation******************\n");
    printf("**********Input****************************\n");
    printf("Second line\n");
    printf("first line\n");
    printf("**********Output***************************\n");
    DLListBefore(myList, "Second line");
    showDLList(stdout,myList);
    printf("nitems is %d\n", DLListLength(myList));
    printf("curr is %s\n", DLListCurrent(myList));
    printf("Condition: %d item in list\n", DLListLength(myList));
    assert(validDLList(myList));

    printf("\n");
    printf("\n");

    printf("TEST 3: Add in the middle of the list\n");
    printf("\n");
    printf("**********Before Operation*****************\n");
    printf("curr is %s\n", DLListCurrent(myList));
    printf("nitems is %d\n", DLListLength(myList));
    printf("Condition: %d item in list\n", DLListLength(myList));
    printf("\n");

    printf("**********After Operation******************\n");
    printf("**********Input****************************\n");
    printf("Second line\n");
    printf("Thrid line\n");
    printf("first line\n");
    printf("**********Output***************************\n");
    DLListMove(myList, 1);
    DLListBefore(myList, "Third line");
    showDLList(stdout,myList);
    printf("nitems is %d\n", DLListLength(myList));
    printf("curr is %s\n", DLListCurrent(myList));
    printf("Condition: %d item in list\n", DLListLength(myList));
    assert(validDLList(myList));

    printf("\n");
   

    assert(validDLList(myList));
    printf("Test success!\n");
    printf("\n");
    printf("\n");




    
    printf("**********Testing DLListAfter*************\n");
    printf("\n");
    
    DLList myListAfter;
    myListAfter = getDLList(stdin);

    

    printf("**********Testing DLListAfter*************\n");
    printf("\n");

    printf("TEST 1: Add in an empty list\n");
    printf("\n");
    printf("**********Before Operation*****************\n");
    printf("curr is NULL\n");
    printf("nitems is %d\n", DLListLength(myListAfter));
    printf("Condition: %d item in list\n", DLListLength(myListAfter));
    printf("\n");

    printf("**********After Operation******************\n");
    printf("**********Input****************************\n");
    printf("first line\n");
    printf("**********Output***************************\n");
    DLListAfter(myListAfter, "first line");
    showDLList(stdout,myListAfter);
    printf("nitems is %d\n", DLListLength(myListAfter));
    printf("curr is %s\n", DLListCurrent(myListAfter));
    printf("Condition: %d item in list\n", DLListLength(myListAfter));
    assert(validDLList(myListAfter));

    printf("\n");
    printf("\n");

    printf("TEST 2: Add after the first or last one\n");
    printf("\n");
    printf("**********Before Operation*****************\n");
    printf("curr is %s\n", DLListCurrent(myListAfter));
    printf("nitems is %d\n", DLListLength(myListAfter));
    printf("Condition: %d item in list\n", DLListLength(myListAfter));
    printf("\n");

    printf("**********After Operation******************\n");
    printf("**********Input****************************\n");
    printf("first line\n");
    printf("Second line\n");
    printf("**********Output***************************\n");
    DLListAfter(myListAfter, "Second line");
    showDLList(stdout,myListAfter);
    printf("nitems is %d\n", DLListLength(myListAfter));
    printf("curr is %s\n", DLListCurrent(myListAfter));
    printf("Condition: %d item in list\n", DLListLength(myListAfter));
    assert(validDLList(myListAfter));
    
    printf("\n");
    printf("\n");


    printf("TEST 3: Add in the middle of the list\n");
    printf("\n");
    printf("**********Before Operation*****************\n");
    printf("curr is %s\n", DLListCurrent(myListAfter));
    printf("nitems is %d\n", DLListLength(myListAfter));
    printf("Condition: %d item in list\n", DLListLength(myListAfter));
    printf("\n");

	printf("**********After Operation******************\n");
    printf("**********Input****************************\n");
    
    printf("first line\n");
    printf("Thrid line\n");
    printf("Second line\n");
    printf("**********Output***************************\n");
    DLListMove(myListAfter, -1);
    DLListAfter(myListAfter, "Third line");
    showDLList(stdout,myListAfter);
    printf("nitems is %d\n", DLListLength(myListAfter));
    printf("curr is %s\n", DLListCurrent(myListAfter));
    printf("Condition: %d item in list\n", DLListLength(myListAfter));
    assert(validDLList(myListAfter));

    printf("\n");

    assert(validDLList(myListAfter));
    printf("Test success!\n");
    printf("\n");
    printf("\n");


    
    
  
    
    
    printf("**********Testing DLListDelete*************\n");
    printf("\n");
    
    printf("**********Testing DLListDelete*************\n");
    printf("\n");
    
    printf("TEST 1: Delete the first line\n");
    printf("\n");
    printf("**********Before Operation*****************\n");
    DLListMove(myListAfter,-1);
    DLListBefore(myListAfter,"Before first line");
    printf("curr is %s\n", DLListCurrent(myListAfter));
    printf("nitems is %d\n", DLListLength(myListAfter));
    printf("Condition: %d item in list\n", DLListLength(myListAfter));
    printf("\n");
    
    printf("**********After Operation******************\n\n");
    printf("**********Output***************************\n");
    DLListDelete(myListAfter);
    showDLList(stdout,myListAfter);
    printf("nitems is %d\n", DLListLength(myListAfter));
    printf("curr is %s\n", DLListCurrent(myListAfter));
    printf("Condition: %d item in list\n", DLListLength(myListAfter));
    assert(validDLList(myListAfter));
    
    printf("\n");
    printf("\n");
    
    printf("TEST 2: Delete line in the middle\n");
    printf("\n");
    printf("**********Before Operation*****************\n");
    DLListMove(myListAfter,1);
    printf("curr is %s\n", DLListCurrent(myListAfter));
    printf("nitems is %d\n", DLListLength(myListAfter));
    printf("Condition: %d item in list\n", DLListLength(myListAfter));
    printf("\n");
    
    printf("**********After Operation******************\n\n");
    printf("**********Output***************************\n");
    DLListDelete(myListAfter);
    showDLList(stdout,myListAfter);
    printf("nitems is %d\n", DLListLength(myListAfter));
    printf("curr is %s\n", DLListCurrent(myListAfter));
    printf("Condition: %d item in list\n", DLListLength(myListAfter));
    assert(validDLList(myListAfter));
    

    printf("\n");
    printf("\n");
    
    
    
    printf("TEST 3: Delete the last line\n");
    printf("\n");
    printf("**********Before Operation*****************\n");
    printf("curr is %s\n", DLListCurrent(myListAfter));
    printf("nitems is %d\n", DLListLength(myListAfter));
    printf("Condition: %d item in list\n", DLListLength(myListAfter));
    printf("\n");
    
    printf("**********After Operation******************\n\n");

    printf("**********Output***************************\n");
    DLListDelete(myListAfter);
    showDLList(stdout,myListAfter);
    printf("nitems is %d\n", DLListLength(myListAfter));
    printf("curr is %s\n", DLListCurrent(myListAfter));
    printf("Condition: %d item in list\n", DLListLength(myListAfter));
    assert(validDLList(myListAfter));
    
    printf("\n");
    printf("\n");
    
    printf("TEST 4: Delete the only item in the list\n");
    printf("\n");
    printf("**********Before Operation*****************\n");
    printf("curr is %s\n", DLListCurrent(myListAfter));
    printf("nitems is %d\n", DLListLength(myListAfter));
    printf("Condition: %d item in list\n", DLListLength(myListAfter));
    printf("\n");
    
    printf("**********After Operation******************\n\n");
    printf("**********Output***************************\n");
    DLListDelete(myListAfter);
    showDLList(stdout,myListAfter);
    printf("nitems is %d\n", DLListLength(myListAfter));
    printf("curr is NULL\n");
    printf("Condition: %d item in list\n", DLListLength(myListAfter));
    assert(validDLList(myListAfter));
    
    printf("\n");
    printf("\n");

    printf("TEST 5: Double Delete\n");
    printf("\n");
    printf("**********Before Operation*****************\n");
    printf("curr is NULL\n");
    printf("nitems is %d\n", DLListLength(myListAfter));
    printf("Condition: %d item in list\n", DLListLength(myListAfter));
    printf("\n");
    
    printf("**********After Operation******************\n\n");
    printf("**********Output***************************\n");
    DLListDelete(myListAfter);
    showDLList(stdout,myListAfter);
    printf("nitems is %d\n", DLListLength(myListAfter));
    printf("curr is NULL\n");
    printf("Condition: %d item in list\n", DLListLength(myListAfter));
    assert(validDLList(myListAfter));
    
    printf("\n");

    assert(validDLList(myListAfter));
    printf("Test success!\n");
    printf("\n");
    printf("\n");

    printf("HAHAHAHAHAHAHA ALL TESTS PASSED!\n");
	return 0;
}

