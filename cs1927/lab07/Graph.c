// Graph.c ... implementation of Graph ADT
// Written by John Shepherd, May 2013

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <string.h>
#include "Graph.h"
#include "Queue.h"

// graph representation (adjacency matrix)
typedef struct GraphRep {
	int    nV;    // #vertices
	int    nE;    // #edges
	int  **edges; // matrix of weights (0 == no edge)
} GraphRep;

// check validity of Vertex
int validV(Graph g, Vertex v)
{
	return (g != NULL && v >= 0 && v < g->nV);
}

// make an edge
Edge mkEdge(Graph g, Vertex v, Vertex w, int weight)
{
	assert(g != NULL && validV(g,v) && validV(g,w));
	Edge new = {v,w,weight}; // struct assignment
	return new;
}

// insert an Edge
// - sets (v,w) and (w,v)
void insertEdge(Graph g, Vertex v, Vertex w, int wt)
{
	assert(g != NULL && validV(g,v) && validV(g,w));
	if (g->edges[v][w] == 0) {
		g->edges[v][w] = wt;
		g->edges[w][v] = wt;
		g->nE++;
	}
}

// remove an Edge
// - unsets (v,w) and (w,v)
void removeEdge(Graph g, Vertex v, Vertex w)
{
	assert(g != NULL && validV(g,v) && validV(g,w));
	if (g->edges[v][w] != 0) {
		g->edges[v][w] = 0;
		g->edges[w][v] = 0;
		g->nE--;
	}
}

// create an empty graph
Graph newGraph(int nV)
{
	assert(nV > 0);
    int i, j;
    int **e = malloc(sizeof(int *) *nV);
    assert(e != NULL);
    for(i = 0; i < nV; i++){
        e[i] = malloc(sizeof(int)* nV);
        assert(e[i] != NULL);
        for(j = 0; j < nV; j++){
            e[i][j] = 0;
        }
    }
    Graph new = malloc(sizeof(struct GraphRep));
    new-> nV = nV;
    new-> nE = 0;
    new->edges = e;
    return new;

    
	// dummy ... doesn't create an empty graph
}

// free memory associated with graph
void dropGraph(Graph g)
{
	assert(g != NULL);
    //int **e = g->edges;
    int i;
    for(i = 0; i < g->nV; i++){
        free(g->edges[i]);
    }
    free(g->edges);
    free(g);
 }   

// display graph, using names for vertices
void showGraph(Graph g, char **names)
{
	assert(g != NULL);
	printf("#vertices=%d, #edges=%d\n\n",g->nV,g->nE);
	int v, w;
	for (v = 0; v < g->nV; v++) {
		printf("%d %s\n",v,names[v]);
		for (w = 0; w < g->nV; w++) {
			if (g->edges[v][w]) {
				printf("\t%s (%d)\n",names[w],g->edges[v][w]);
			}
		}
		printf("\n");
	}
}



// find a path between two vertices using breadth-first traversal
// only allow edges whose weight is less than "max"
int findPath(Graph g, Vertex src, Vertex dest, int max, int *path)
{
	assert(g != NULL && validV(g,src) && validV(g,dest));
	int *visited;
	visited = calloc(g->nV, sizeof(int));
	Queue q = newQueue();
	QueueJoin(q, src);
	int *tmppath = malloc(g->nV *sizeof(int));
	int isFound = 0;
	while(!QueueIsEmpty(q) && !isFound){
		Vertex y, x = QueueLeave(q);
		for(y = 0; y < g->nV; y++){
			if(g->edges[x][y] == 0 || g->edges[x][y] > max){
				continue;
			}
			if(!visited[y]){
				visited[x] = 1;
				visited[y] = 1;
				QueueJoin(q, y);
				tmppath[y] = x; 
			}
			if(y == dest){
				isFound = 1;  
				break;
			}
		}
	}
	int i = 0;
	if(isFound){
		Vertex v;
		for (v = dest; v != src; v = tmppath[v]){
			path[i] = v;
			i++;
		}
		path[i] = v;
		i++;
	}
	
	int j = 0;
	int k = i-1;
	while(j <= k){

		Vertex tmp;
		tmp = path[j];
		path[j] = path[k];
		path[k] = tmp;

		j++;
		k--;
	}

	free(visited);
	free(tmppath);
	dropQueue(q);
	
	return i;  // dummy ... always claims there is no path
}
