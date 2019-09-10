//
// Created by C19Mark.Demore on 4/21/2017.
//

#include "Graph.h"
#include <stdlib.h>
#include <stdio.h>

#define FALSE 0
#define TRUE 1

#define WHITE 0
#define GRAY 1
#define BLACK 2

Graph * graphCreate(int numberVertices, int bytesPerNode)
{
    Graph *graph = (Graph *) malloc( sizeof(Graph));
    graph->visited = (int *) malloc((numberVertices * sizeof(int)));
    graph->vertices = malloc(numberVertices * bytesPerNode);
    graph->edges = (int **) malloc( numberVertices * sizeof(int *));
    graph->numberVertices = numberVertices;

    // Create each row of the adjacency matrix
    for (int j=0; j<numberVertices; j++) {
        graph->edges[j] = (int *) malloc( numberVertices * sizeof(int));
        graph->visited[j] = 0;
    }

    // Set every edge to FALSE
    for (int row = 0; row < graph->numberVertices; row++) {
        for (int col = 0; col < graph->numberVertices; col++) {
            graph->edges [row] [col] = FALSE;

        }
    }

    return graph;
}
void    graphDelete(Graph *graph)
{
    for (int row = 0; row < graph->numberVertices; row++) {
        for (int col = 0; col < graph->numberVertices; col++) {
            free(&graph->edges[row][col]);
        }
    }

    free(graph);

}
void    graphSetEdge(Graph *graph, int fromVertex, int toVertex, int state)
{

    if (fromVertex >= 0 && fromVertex <= graph->numberVertices &&
        toVertex >= 0 && toVertex <= graph->numberVertices) {
        graph->edges[fromVertex][toVertex] = state;
    }

}
int     graphGetEdge(Graph *graph, int fromVertex, int toVertex)
{
    return graph->edges [fromVertex] [toVertex];
}
