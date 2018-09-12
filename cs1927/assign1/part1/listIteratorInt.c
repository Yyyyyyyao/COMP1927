/*
  listIteratorInt.c ... list Iterator ADT implementation
  Written by .... 
  Date: ....
*/

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "listIteratorInt.h"

typedef struct Node {

  // implement struct here .. 
    int val;
    struct Node *next;
    struct Node *prev;

} Node;

typedef struct IteratorIntRep {

  // implement struct here .. 
    struct Node *first;
    struct Node *last;
    struct Node *cursor;
    int size;
    int *returnval;
    struct Node *returnflag;


} IteratorIntRep;



/*

  Your local functions here, if any.... 


 */
Node *createNode(int v);
Node *createNode(int v){
    Node *new = malloc(sizeof(struct Node));
    new->val = v;
    new->next = NULL;
    new->prev = NULL;

    return new;
}



IteratorInt IteratorIntNew(){

  // implement this function 
    IteratorInt new = malloc(sizeof(struct IteratorIntRep));
    new->first = NULL;
    new->last = NULL;
    new->cursor = createNode(0);
    new->size = 0;
    new->returnval = 0;
    new->returnflag = NULL;

  return new;  // you need to change this...
}

void reset(IteratorInt it){

  // implement this function 
    assert(it != NULL);
    it->returnflag = NULL; 
    it->cursor->prev = NULL;
    it->cursor->next = it->first;

}


int add(IteratorInt it, int v){
  
  // implement this function 
    assert(it != NULL);
    struct Node *new = createNode(v);
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


int hasNext(IteratorInt it){// like: ^ 12 23{
  
  // implement this function
    assert(it != NULL);
    it->returnflag = NULL; 
    if(it->cursor->next != NULL){
        return 1;
    }else{
        return 0;
    }
   // you need to change this...
}

int hasPrevious(IteratorInt it){
  
  // implement this function 
    assert(it != NULL);
    it->returnflag = NULL; 
    if(it->cursor->prev != NULL){
        return 1;
    }else{
        return 0;
    }
   // you need to change this...
}


int *next(IteratorInt it){
  
  // implement this function
    assert(it != NULL); 
    if(hasNext(it) == 1){ // 12 13 14 15 ^ 16
        it->cursor->prev = it->cursor->next;
        it->cursor->next = it->cursor->next->next;
        it->returnval = &it->cursor->prev->val;
        it->returnflag = it->first;
        return it->returnval;
    }else{
        return NULL;
    }
  
  // you need to change this...
}

int *previous(IteratorInt it){

  // implement this function 
    assert(it != NULL);
    if(hasPrevious(it) == 1){
        it->cursor->next = it->cursor->prev;
        it->cursor->prev = it->cursor->prev->prev;
        it->returnval = &it->cursor->next->val;
        it->returnflag = it->first;
        return it->returnval;
    }else{
        return NULL;
    }
   // you need to change this...

}


int delete(IteratorInt it){
  
  // implement this function 
    assert(it != NULL);
    if(it->returnflag != NULL){   //to see whether it is satisfy the conditions
          Node *curr = NULL;
        if(it->cursor->prev->val == *it->returnval){
            curr = it->cursor->prev;         //to see the value to delete is previous or not
        }else if(it->cursor->next->val == *it->returnval){
            curr = it->cursor->next;         //to see the value to delete is next or not
        }
        curr->next->prev = curr->prev;       //move the cursor
        curr->prev->next = curr->next;
        it->cursor->prev = curr->prev;
        it->cursor->next = curr->next;
        if(curr == it->first){
            it->first = curr->next;
        }else if(curr == it->last){
            it->last = curr->prev;
        }
    free(curr);                         //delete the value
    it->size--;                        
        it->returnflag = NULL;
        return 1;
    }else{
        return 0;
    }
   // you need to change this...
}


int set(IteratorInt it, int v){
  
  // implement this function 
    assert(it != NULL);
    if(it->returnflag != NULL){
        *it->returnval = v;
        it->returnflag = NULL; 
        return 1;
    }else{
        return 0;
    }

      
}

int *findNext(IteratorInt it, int v){

  // implement this function
    assert(it != NULL);
    Node *curr = it->cursor->next;             // 1 2 3 4 ^ 8 9 2
    int flag = 0;
    while(curr != NULL){
        if(curr->val == v){
            it->cursor->prev = curr;
            it->cursor->next = curr->next;
            flag = 1;
        break;
        }
        curr = curr->next;
    }
    if(flag == 1){
        it->returnval = &it->cursor->prev->val;
        it->returnflag = it->first;
            return it->returnval;
    }else{
        return NULL;
    }
  
}

int *findPrevious(IteratorInt it, int v){
  
  // implement this function 
    assert(it != NULL);
    Node *curr = it->cursor->prev;
    int flag = 0;
    while(curr != NULL){
        if(curr->val == v){
            it->cursor->next = curr;
            it->cursor->prev = curr->prev;
            flag = 1;
      break;
        }
        curr = curr->prev;
    }
    if(flag == 1){
        it->returnval = &it->cursor->next->val;
        it->returnflag = it->first;
        return it->returnval;
    }else{
        return NULL;
    }
    
}



