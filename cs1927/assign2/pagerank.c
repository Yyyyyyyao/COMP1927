#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <string.h>
#include <math.h>
#include "graph.h"
#include "set.h"
#include "readData.h"
#include "BSTree.h"

#define MAX 1000

static int less(Link x, Link y){
    return x->PR < y->PR;
}

static void swap(Set c, Link i, Link j){
    i->next = j->next;
    j->prev = i->prev;
    if(j->next != NULL){
        j->next->prev = i;
    }
    if(i->prev != NULL){
        i->prev->next = j;
    }
    i->prev = j;
    j->next = i;
    if(j->prev == NULL){
        c->elems = j;
    }
}

Set PageRank(double d, double diffPR, int maxIterations);
Set order (Set c);

static double calculation(Link pr, Graph g, Set c, double prev[]){


    double result = 0;
    Link curr = c->elems;
    int i = 0;
    while(curr != NULL){

        if(isConnected(g, curr->val, pr->val)){
            double L = 0;
            Link temp = c->elems;

            while(temp != NULL){ //loop to find L which is the number

                if(isConnected(g, curr->val, temp->val)){ 
                    L++;
                }

                temp = temp->next;
            }
            curr->L = L;
            result = result + (prev[i])/(double)L;
            
        }
        i++;
        curr = curr->next;
    }

    return result;
}

static Set bubbleSort(Set c){

    Link i, j = c->elems;
    int nswaps;
    for (j = c->elems; ; j = j->next){
        nswaps = 0;
        i = c->elems;
        while(i->next != NULL){
            if(less(i, i->next)){
                swap(c, i, i->next);
                nswaps++;
            }else{
                i = i->next;
            }
        }

        if(nswaps == 0){
            break;
        }
        j = c->elems;
    }

    return c;

}

static void output(Set c){
    FILE *fp = fopen("pagerankList.txt","w");
    Link curr = c->elems;
    while(curr != NULL){
        fprintf(fp, "%s, %d, %.7lf\n", curr->val, curr->L, curr->PR);
        curr = curr->next;
    }
    fclose(fp);
}

int main(int argc, char **argv){

    if(argc != 4){
        printf("Invalid input!\n");
        printf("Usage: ./pagerank d diffPR maxIterations\n");
    }else{
        Set new = PageRank(atof(argv[1]), atof(argv[2]), atof(argv[3]));
        new = order(new);
        assert(new != NULL);
    }

    return EXIT_SUCCESS;
}


Set PageRank(double d, double diffPR, int maxIterations){
    Set c = GetCollection();
    Graph g = GetGraph(c);
    int N =  nVertices(g);
    double prev[MAX] = {0}; //to store the last iteration's PR
    int i = 0;
    Link curr = c->elems;
    while(curr != NULL){

        curr->PR = 1/(double)N;
        prev[i] = curr->PR;
        i++;
        curr = curr->next;
    }


    int iteration = 0;
    double diff = diffPR;



    while(iteration < maxIterations && diff >= diffPR){
        Link pr = c->elems;
        iteration++;

        while(pr != NULL){

            //pr->Prev_PR = pr->PR;
            pr->PR = (1-d)/(double)N + d*(calculation(pr, g, c, prev));
            pr = pr->next;
        }

        diff = 0;
        Link temp = c->elems;
        i = 0;
        while(temp != NULL){

            diff = diff + fabs(temp->PR - prev[i]);

            i++;
            temp = temp->next;
        }
        i = 0;
        Link curr = c->elems;
        while(curr != NULL){  //this loop is to store the previous pagerank

            curr->Prev_PR = prev[i]; 
            prev[i] = curr->PR;
            i++;
            curr = curr->next;

        }

    }


    return c;   

}

Set order (Set c){
    c = bubbleSort(c);
    output(c);
    return c;
}



