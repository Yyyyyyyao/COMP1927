#include "list.h"

link deleteEven(link l) {
  // TODO: Your implementation here
  	link prev = NULL;
  	link curr = l;
  	link head = l;
  	while(curr != NULL){
  		if(curr->next % 2 == 0){
  			if(prev == NULL){
  				head = curr->next;
  				free(curr);
  				curr = head;
  			}else{
  				prev->next = curr->next;
  			}
  		}else{
  			prev = curr;
  			curr = curr->next;
  		}
	}
	return head;
}

void printList (link list) {
  link curr = list;
  while (curr != NULL) {
    printf ("[%d]->", curr->item);
    curr = curr->next;
  }
  printf ("[X]\n");
}


link fromTo (int start, int end) {
  int i;
  link list = NULL;
  link tail = NULL;
  for(i = start; i <= end; i++){
    link n = newNode(i);   
    if(list == NULL){
      list = n;     
    } else {
      tail->next = n;     
    }
    tail = n;
  }
  return list;
}

link newNode(Item it) {
  link newNode = malloc(sizeof(node));
  newNode->next = NULL;
  newNode->item = it;
  return newNode;
}

void printLink(link l){
  if(l==NULL) return;
  printf("[%d]\n",l->item);
}

