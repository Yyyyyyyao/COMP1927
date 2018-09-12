#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <ctype.h>
#include <math.h>
#include "readData.h"
#include "BSTree.h"
#include "graph.h"
#include "searchTfIdf.h"

#define MAX_LENGTH 1000
#define MAXLENGTH 1000
static char *nextWord(char *word){

    char *c;
    c = strstr(word, " ");
    if(c == NULL){ //if one line, at the end, there is no spaces but \n
        return NULL; //it will return NULL
    }
    return c;
}

static char *nextURL(char *s){
    char *c;
    c = strstr(s, "url");
    if(c == NULL){
        return NULL;
    }
    return c;
}

static void validWord(char *word){
    int i = 0;
    while(word [i]){
        word[i] = tolower(word[i]);
        if(!isalpha(word[i])){
            word[i] = '\0';
        }
        i++;
    }
}

static int less(Link x, Link y){
    return x->tf_idf < y->tf_idf;
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
    }
    j = c->elems;
    return c;

}

double Idf(Graph g, Set s);
int countWord(char *file, char *words);
Set findMatchUrls(char *file, char *argv[]);

int main(int argc, char *argv[])
{

    Set c = GetCollection();
    Graph g = GetGraph(c);
    Set s = findMatchUrls("invertedIndex.txt", argv); //find the match urls set 
    Link curr = s->elems;
    double idf = Idf(g, s);
    while(curr != NULL){
        int tf = 0;
        int i = 1;
        double tf_idf;
        char filename[MAXLENGTH];
        strcpy(filename, curr->val);
        strcat(filename, ".txt");

        while(argv[i] != NULL){
            validWord(argv[i]);
            tf = tf + countWord(filename, argv[i]);     //tf of one url is the 
            i++;                                        //sum of the numbers of the 
                                                        //words that i search
        } 

        tf_idf = (double)tf * (double)idf;  
        curr->tf_idf = tf_idf;                          //stored into set
                                                        //help us to use sort
        curr = curr->next;
    }

    s = bubbleSort(s);
    showSetinTfidf(s);
    return EXIT_SUCCESS;
}


int countWord(char *file, char *words){

    int num = 0;
    char line[MAXLENGTH];
    FILE *fp = fopen(file, "r");
    fgets(line, MAXLENGTH, fp);
    while(strncmp(line, "#start Section-2", 16) != 0){//this loop is to find the start 
        fgets(line, MAXLENGTH, fp);                    //of the content
    }                                           

    fgets(line, MAXLENGTH, fp);         //get rid of the line 
                                        //that under the #start Section-2
    while(!feof(fp)){
        char *word;
        fgets(line, MAXLENGTH, fp);
        if(strncmp(line, "#end Section-2", 14) == 0){//use to find the end of the content
            break;
        }
        word = line;
        char sub_word[MAXLENGTH];       //e.g. word: abc bcd ibd
        sscanf(word, "%s", sub_word);  //because words are seperate by space 
                                       //therefore, i can get one word from line
                                        // abc->sub_word
        while(sub_word != NULL){
            word = strstr(word, sub_word);//cut the space before the sub_word
            if(word == NULL){       //word might be NULL
                break;
            }
            word = nextWord(word);      //find the next space, cut the sub_word before
                                        //word: bcd ibd
            validWord(sub_word);    //convert sub_word into lowercase and cur the punctuations
            if(strcmp(sub_word, words) == 0){ //compare sub_word with the target word
                num++;
            }
            
            if(word == NULL){   //because nextWord function might return NULL
                break;
            }
            sscanf(word, "%s", sub_word);   //scan next single word from the rest words
        }
    }

    fclose(fp);


    return num;
}


double Idf(Graph g, Set s){

    int nV = nVertices(g);
    double idf;
    double i = (double)(nV)/(double)(s->nelems);
    idf = log10(i);
    return idf;

}

Set findMatchUrls(char *file, char *argv[]){  //it is the same function in searchPagerank.c

    Set new = newSet();

    char line[MAXLENGTH];
    int a = 1;
    while(argv[a] != NULL){
        validWord(argv[a]);
        a++;
    }

    int i = 1;

    while(i < a){

        FILE *fp = fopen(file, "r");
        fgets(line, MAXLENGTH, fp);
        while(!feof(fp)){
            char words[MAXLENGTH];
            sscanf(line, "%s", words);
            if(strcmp(words, argv[i]) == 0){
                char *url;
                url = line;
                while((url = nextURL(url)) != NULL){
                    char sub_url[1000];
                    sscanf(url, "%s", sub_url);
                    insertIntoS(new, sub_url);
                    url++;
                }

            }


            fgets(line, MAXLENGTH, fp);
        }

        fclose(fp);
        i++;
    }

    Link curr = new->elems;
    Link temp = new->elems;
    Set s = newSet();

    while(curr != NULL){
        int counter = 0;
        //temp = new->elems;
        temp = curr;
        while(temp != NULL){
            if(strcmp(curr->val, temp->val) == 0){
                counter++;
            }
            temp = temp->next;
        }
        if(counter == (a-1)){
            if(!isElem(s, curr->val)){
                insertIntoS(s, curr->val);
            }
        }

        curr = curr->next;

    }

    return s;
}