#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>
#include "set.h"
#include "searchPagerank.h"

#define MAXLENGTH 1000

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
        if(word[i] == ','){
            word[i] = '\0';
        }
        i++;
    }
}

int main(int argc, char *argv[]){

    Set s = findMatchUrls("invertedIndex.txt", argv);
    Set sp = findPagerank("pagerankList.txt", s);
    Link curr = sp->elems;
    int counter = 0;

    while(curr != NULL && counter < 10){
        printf("%s\n", curr->val);
        counter++;
        curr = curr->next;
    }
    
    return EXIT_SUCCESS;
}

Set findMatchUrls(char *file, char *argv[]){

    Set new = newSet();

    char line[MAXLENGTH];
    int a = 1;
    while(argv[a] != NULL){ // a = 1 + argc
        a++;
    }

    int i = 1;

    while(i < a){

        FILE *fp = fopen(file, "r");
        fgets(line, MAXLENGTH, fp);
        while(!feof(fp)){
            char words[MAXLENGTH];
            sscanf(line, "%s", words);
            if(strcmp(words, argv[i]) == 0){ // to see which word is match
                char *url;
                url = line;
                while((url = nextURL(url)) != NULL){  //if matched, store the urls 
                    char sub_url[1000];               //into list
                    sscanf(url, "%s", sub_url);         
                    insertIntoS(new, sub_url);         //at this step, do not care 
                    url++;                              //duplicates 
                }

            }


            fgets(line, MAXLENGTH, fp);
        }

        fclose(fp);
        i++;
    }

    Link curr = new->elems;
    Link temp = new->elems;
    Set s = newSet();           //result stores in Set s.
    while(curr != NULL){
        int counter = 0;
        temp = curr;
        while(temp != NULL){
            if(strcmp(curr->val, temp->val) == 0){ //to see each url appears 
                counter++;                          //how mant times
            }
            temp = temp->next;
        }
        if(counter == (a-1)){       //if the number equals the number of argc
            if(!isElem(s, curr->val)){
                insertInto(s, curr->val);   //so it is the intersection of two words
            }
        }

        curr = curr->next;

    }

    return s;
}



Set findPagerank(char *file, Set url_list){

    Set new = newSet();
    char line[MAXLENGTH];
    FILE *fp = fopen(file, "r");
    fgets(line, MAXLENGTH, fp);
    while(!feof(fp)){
        char word[MAXLENGTH];
        sscanf(line, "%s", word);
        validWord(word);

        Link curr = url_list->elems;
        while(curr != NULL){
            if(strcmp(curr->val, word) == 0){ //find the matched words 

                insertIntoS(new, curr->val);   //insert in order of find


            }

            curr = curr->next;
        }


        fgets(line, MAXLENGTH, fp);
    }
    fclose(fp);

    char words[MAXLENGTH];
    double PR;
    int L;
    FILE *fp1 = fopen(file, "r");
    while(!feof(fp1)){
        fscanf(fp, "%s %d, %lf\n", words, &L, &PR); //store values to the new set
        validWord(words);
        Link temp = new->elems;
        while(temp != NULL){
            if(strcmp(temp->val, words) == 0){
                temp->PR = PR;
                temp->L = L;
            }
            temp = temp->next;
        }
    }
    fclose(fp1);

    return new;
}
