#ifndef READDATA_H
#define READDATA_H

#include "set.h"
#include "graph.h"
#include "BSTree.h"
// Function signatures

Set GetCollection();
Graph GetGraph(Set s);
BSTree Getwords(BSTree t, char *fp);
BSTree invertedList(Set c);
BSTree InvertedIndex();

#endif
