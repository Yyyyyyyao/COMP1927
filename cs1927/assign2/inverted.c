#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <string.h>
#include <math.h>
#include "graph.h"
#include "set.h"
#include "readData.h"
#include "BSTree.h"
#include "inverted.h"

int main(void){

    InvertedIndex();

    return 0;
}

BSTree InvertedIndex(){
    Set new = GetCollection();
    BSTree t = invertedList(new);
    return t;

}

BSTree invertedList(Set c){

    BSTree t = newBSTree();
    Link curr = c->elems;
    while(curr != NULL){

        t = Getwords(t, curr->val);

        curr = curr->next;
    }


    BSTreeInfix(t);


    return t;
}


