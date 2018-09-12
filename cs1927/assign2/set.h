// set.h ... interface to simple Set of Strings
// Written by John Shepherd, September 2015

#ifndef SET_H
#define SET_H

typedef struct SetRep *Set;


typedef struct Node *Link;

typedef struct Node {
    char *val;
    double PR;
    double Prev_PR;
    int L;
    double tf_idf;
    Link  next;
    Link  prev;
} Node;
    
typedef struct SetRep {
    int   nelems;
    Link  elems;
} SetRep;

// Function signatures

Set newSet();
void disposeSet(Set);
void insertInto(Set,char *);
void dropFrom(Set,char *);
int  isElem(Set,char *);
int  nElems(Set);
void showSet(Set);
void insertIntoS(Set s, char *str);
void showSetinTfidf(Set s);

#endif
