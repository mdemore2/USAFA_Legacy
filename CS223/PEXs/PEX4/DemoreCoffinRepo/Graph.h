/** Graph.h
 * ===========================================================
 * Name: Dr. Wayne Brown, Spring 2017
 * Modified by: Demore/Coffin
 * Section: T3A
 * Project: PEX4
 * Purpose: The definition of a graph.
 * ===========================================================
 */

#ifndef GRAPH_H
#define GRAPH_H

#include<stdlib.h>

typedef struct graph{
	int    numberVertices;
    int  * visited;
	void * vertices;  // Array of nodes
	int ** edges;     // Adjacency matrix (2D Array)
	int ** distance;
} Graph;

Graph * graphCreate(int numberVertices, int bytesPerNode);
void    graphDelete(Graph *graph);
void    graphSetEdge(Graph *graph, int fromVertex, int toVertex, int state);
int     graphGetEdge(Graph *graph, int fromVertex, int toVertex);


#endif // GRAPH_H