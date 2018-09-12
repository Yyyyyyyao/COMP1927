#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>
#include "graph.h"
#include "set.h"
#include "BSTree.h"
#include "readData.h"

#define MAXLENGTH 1000


static Set GetUrls(char *fp);


static char* nextURL(char *s){
    char *c;
    c = strstr(s, "url");
    if(c == NULL){
        return NULL;
    }
    return c;
}

static Set GetUrls(char *fp){
    Set new = newSet();
    char *url;
    char line[MAXLENGTH];
    FILE *file = fopen(fp, "r");
    fgets(line, MAXLENGTH, file);
    while(!feof(file)){
        url = line;
        while((url = nextURL(url)) != NULL){
            char sub_url[1000];
            sscanf(url, "%s", sub_url);
            if(!isElem(new, sub_url)){
                insertInto(new, sub_url);
            }
            url++;
        }
        fgets(line, MAXLENGTH, file);
    }
    fclose(file);
    return new;
}

static char *nextWord(char *word){

    char *c;
    c = strstr(word, " ");
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

BSTree Getwords(BSTree t, char *fp){//   char *fp = url11

    char line[MAXLENGTH];
    char a[MAXLENGTH];
    strcpy(a, fp);
    strcat(a, ".txt");
    FILE *file = fopen(a, "r");
    
    fgets(line, MAXLENGTH, file);
    while(strncmp(line, "#start Section-2", 16) != 0){
        fgets(line, MAXLENGTH, file);
    }

    fgets(line, MAXLENGTH, file);
    while(!feof(file)){
        char *word;
        fgets(line, MAXLENGTH, file);
        if(strncmp(line, "#end Section-2", 14) == 0){
            break;
        }
        word = line;
        char sub_word[MAXLENGTH];
        sscanf(word, "%s", sub_word);
        while(sub_word != NULL){
            word = strstr(word, sub_word); //"     " with () return NULL
            if(word == NULL){
                break;
            }
            word = nextWord(word);
            validWord(sub_word);
            t = BSTreeInsert(t, sub_word, fp);

            if(word == NULL){
                break;
            }
            sscanf(word, "%s", sub_word);
        }

    }
    fclose(file);
    return t;
}

Set GetCollection(){
    Set new = newSet();
    new = GetUrls("collection.txt");
    return new;
}

Graph GetGraph(Set s){

    Graph g = newGraph(MAXLENGTH);
    Link curr;
    curr = s->elems;
    while(curr != NULL){
        char a[MAXLENGTH];
        strcpy(a, curr->val);
        strcat(a, ".txt");
        Set temp = GetUrls(a);
        Link pass;
        pass = temp->elems;
        while(pass != NULL){

            if(!isConnected(g, curr->val, pass->val)){
                addEdge(g, curr->val, pass->val);
            }

            pass = pass->next;
        }

        curr = curr->next;
    }


    return g;
}




