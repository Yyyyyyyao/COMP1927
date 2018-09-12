// listIteratorG.c ... Generic List Iterator implementation
// Written by .... 

/* 
    You need to submit ONLY this file.... 

*/

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "listIteratorG.h"

typedef struct Node {

  // implement struct here .. 
	void *val;
	struct Node *next;
	struct Node *prev;
	

} Node;

typedef struct IteratorGRep {

  // implement struct here .. 
	struct Node *first;
    struct Node *last;
    struct Node *cursor;
    int size;
    void *returnval;
    struct Node *returnflag;

    ElmCompareFp cmp;
    ElmCopyFp copy;
    ElmFreeFp free;


} IteratorGRep;


/*

  Your  functions here .... 


 */
Node *createNode();
Node *createNode(){
    Node *new = malloc(sizeof(struct Node));
    new->val = NULL;
    new->next = NULL;
    new->prev = NULL;

    return new;
}



IteratorG IteratorGNew(ElmCompareFp cmp, ElmCopyFp copy, ElmFreeFp free){

  // implement this function 
    IteratorG new = malloc(sizeof(struct IteratorGRep));
    new->first = NULL;
    new->last = NULL;
    new->cursor = createNode(0);
    new->size = 0;
    //new->returnval = NULL;
    new->returnflag = NULL;
    new->cmp = cmp;
    new->copy = copy;
    new->free = free;

  return new;  // you need to change this...
}

void reset(IteratorG it){

  // implement this function 
    assert(it!=NULL);
    it->cursor->prev = NULL;
    it->cursor->next = it->first;
    it->returnflag=NULL;

}


int add(IteratorG it, void *vp){
  
  // implement this function 
    assert(it!=NULL);
    struct Node *new = createNode();
    new->val = it->copy(vp);
    if(it->size == 0){              // case: ^ 
        it->first = new;
        it->last = new;
        it->cursor->prev = new;
    }else if(it->cursor->prev == NULL){ // case first : ^ 12 23
        new->next = it->cursor->next;
        it->cursor->next->prev = new;
        it->cursor->prev = new;
        it->cursor->next = new->next;
        it->first = new; 
    }else if(it->cursor->next == NULL){ // case last: 12 13 ^
        new->prev = it->cursor->prev;
        it->cursor->prev->next = new;
        it->cursor->prev = new;
        it->cursor->next = NULL;
        it->last = it->cursor->prev;
    }else{                          // case middle: 12 ^ 13
        new->prev = it->cursor->prev;
        new->next = it->cursor->next;
        it->cursor->prev->next = new;
        it->cursor->next->prev = new;
        it->cursor->prev = new;
        it->cursor->next = new->next;
    }
    it->size++;
    it->returnflag = NULL;
    return 1;
  // you need to change this...
}


int hasNext(IteratorG it){// like: ^ 12 23{
  
  // implement this function 
    assert(it!=NULL);
    it->returnflag = NULL;
    if(it->cursor->next != NULL){
        return 1;
    }else{
        return 0;
    }

   // you need to change this...
}

int hasPrevious(IteratorG it){
  
  // implement this function 
    assert(it!=NULL);
    it->returnflag = NULL;
    if(it->cursor->prev != NULL){
        return 1;
    }else{
        return 0;
    }
   // you need to change this...
}


void *next(IteratorG it){
  
  // implement this function
    assert(it!=NULL);
    if(hasNext(it) == 1){ // 12 13 14 15 ^ 16
        it->cursor->prev = it->cursor->next;
        it->cursor->next = it->cursor->next->next;
        it->returnval = it->cursor->prev->val;
        it->returnflag = it->first;
        return it->returnval;
    }else{
    	return NULL;
    }
  
  // you need to change this...
}

void *previous(IteratorG it){

  // implement this function 
    assert(it!=NULL);
    if(hasPrevious(it) == 1){
        it->cursor->next = it->cursor->prev;
        it->cursor->prev = it->cursor->prev->prev;
        it->returnval = it->cursor->next->val;
        it->returnflag = it->first;
        return it->returnval;
    }else{
    	return NULL;
    }
   // you need to change this...

}


int delete(IteratorG it){
  
  // implement this function
    assert(it!=NULL);
	if(it->returnflag != NULL){
		Node *curr = NULL;
		if(it->cursor->prev->val == it->returnval){
			curr = it->cursor->prev;
		}else if(it->cursor->next->val == it->returnval){
			curr = it->cursor->next;
		}
		curr->next->prev = curr->prev;
		curr->prev->next = curr->next;
		it->cursor->prev = curr->prev;
		it->cursor->next = curr->next;
		if(curr == it->first){
            it->first = curr->next;
        }else if(curr == it->last){
            it->last = curr->prev;
        }
		free(curr);
        it->size--;
		it->returnflag = NULL;
		return 1;
	}else{
		return 0;
	}
   // you need to change this...
}


int set(IteratorG it, void *vp){
  
  // implement this function 
    assert(it!=NULL);
	if(it->returnflag != NULL){
		it->returnval = vp;
        it->returnflag = NULL;
		return 1;
	}else{
		return 0;
	}

  	
}

void *findNext(IteratorG it, void *vp){

  // implement this function
    assert(it!=NULL);
    Node *curr = it->cursor->next;
    int flag = 0;
    while(curr != NULL){
    	if(it->cmp(curr->val, vp) == 0){
    		it->cursor->prev = curr;
    		it->cursor->next = curr->next;
    		flag = 1;
        break;
    	}
    	curr = curr->next;
    }
    if(flag == 1){
    	it->returnval = it->cursor->prev->val;
    	it->returnflag = it->first;
		  return it->returnval;
    }else{
    	return NULL;
    }
  
}

void *findPrevious(IteratorG it, void *vp){
  
  // implement this function 
    assert(it!=NULL);
	Node *curr = it->cursor->prev;
	int flag = 0;
	while(curr != NULL){
		if(it->cmp(curr->val, vp) == 0){
			it->cursor->next = curr;
			it->cursor->prev = curr->prev;
			flag = 1;
            break;
		}
		curr = curr->prev;
	}
	if(flag == 1){
		it->returnval = it->cursor->next->val;
		it->returnflag = it->first;
		return it->returnval;
	}else{
		return NULL;
	}
	
}

// --------------------------------------





