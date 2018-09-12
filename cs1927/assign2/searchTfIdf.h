

#ifndef SEARCHTFIDF_H
#define SEARCHTFIDF_H

#include "graph.h"
#include "set.h"
#include "readData.h"


Set orderOut(Set s);
Set tfidf (Set n, char *argv[]);
int countNumWord (char *filename, char *word);
int tf (char *filename, char *word);
double idfnum (Set url);

#endif