// BSTree.h ... interface to binary search tree ADT

#ifndef BSTREE_H
#define BSTREE_H

typedef struct BSTNode *BSTree;
typedef struct Node_url *ListNode;

/*
typedef struct BSTNode {
    char* value;
    ListNode urlList;
    BSTLink left, right;
} BSTNode;

typedef struct Node{
    char *url;
    ListNode next;
} Node;
*/

// create an empty BSTree
BSTree newBSTree();
// free memory associated with BSTree
void dropBSTree(BSTree);
// display a BSTree
void showBSTree(BSTree);
// display BSTree root node
void BSTreeInfix(BSTree t);

ListNode newNode(char *v);
// print values in infix order
/*void BSTreeInfix(BSTree);
// print values in prefix order
void BSTreePrefix(BSTree);
// print values in postfix order
void BSTreePostfix(BSTree);
// print values in level-order
void BSTreeLevelOrder(BSTree);
*/
// count #nodes in BSTree
int BSTreeNumNodes(BSTree);
// count #leaves in BSTree
//int BSTreeNumLeaves(BSTree);

// insert a new value into a BSTree
BSTree BSTreeInsert(BSTree t, char* v, char *url);
// check whether a value is in a BSTree
ListNode BSTreeFind(BSTree, char*);
// delete a value from a BSTree
BSTree BSTreeDelete(BSTree, char*);

#endif
