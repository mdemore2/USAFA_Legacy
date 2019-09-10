/** GraphA.c
 * ===========================================================
 * Name:              , Spring 2017
 * Section:
 * Project: Graphs
 * Purpose: Implement a graph using arrays (an adjacency matrix)
 * ===========================================================
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <limits.h>
#include "GraphP.h"

void findShortestPath(Graph * graph, int from, int end);

//---------------------------------------------------------------------
Graph * graphCreate(int numberNodes) {
    Graph *graph = (Graph *) malloc( sizeof(Graph));

    graph->numberVertices = numberNodes;
    graph->vertices = (Vertex *) malloc( numberNodes * sizeof(Vertex));
    graph->edges = (int **) malloc( numberNodes * sizeof(int *));

    // Create each row of the adjacency matrix
    for (int j=0; j<numberNodes; j++) {
        graph->edges[j] = (int *) malloc( numberNodes * sizeof(int));
    }

    // Set every edge to FALSE
    for (int row = 0; row < graph->numberVertices; row++) {
        for (int col = 0; col < graph->numberVertices; col++) {
            graph->edges[row][col] = 0;
        }
    }

    return graph;
}

//---------------------------------------------------------------------
void graphAddEdge(Graph * graph, int fromNode, int toNode, int weight) {

    if (fromNode >= 0 && fromNode < graph->numberVertices &&
        toNode   >= 0 && toNode   < graph->numberVertices) {
        graph->edges[fromNode][toNode] = weight;
    }
}

//---------------------------------------------------------------------
void printGraph(Graph * graph) {
    printf("     TO:  ");
    for (int j = 0; j < graph->numberVertices; j++){
        printf("%3d ", j);
    }
    printf("\n");

    for (int j = 0; j < graph->numberVertices; j++){
        printf("FROM %d : ", j);
        for (int k = 0; k < graph->numberVertices; k++) {
            printf(" %3d", graph->edges[j][k]);
        }
        printf("\n");
    }
    printf("\n");
}

//---------------------------------------------------------------------
Path * createPath(int maxLength) {
    Path *path = (Path *) malloc(sizeof(Path));

    path->numberVertices = 0;
    path->maxLength = maxLength;
    path->vertices = (int *) malloc( sizeof(int) * maxLength);
    path->totalCost = 0;

    return path;
}

//---------------------------------------------------------------------
void deletePath(Path *path) {
    free(path->vertices);
    free(path);
}

//---------------------------------------------------------------------
void copyPath(Path * to, Path * from) {
    to->numberVertices = from->numberVertices;
    to->maxLength      = from->maxLength;
    memcpy(to->vertices, from->vertices, sizeof(int) * from->maxLength);
    to->totalCost      = from->totalCost;
}

//---------------------------------------------------------------------
void printPath(Path * path) {
    printf("Path cost: %3d  Path length: %2d, Path vertices: ",
           path->totalCost, (path->numberVertices-1));
    for (int j=0; j<path->numberVertices; j++) {
        printf("%d ", path->vertices[j]);
    }
    printf("\n");
}

//---------------------------------------------------------------------
static Path * currentPath = NULL;
static Path * bestPath = NULL;

Path  * graphFindShortestPath(Graph * graph, int start, int end) {
    // Mark all the vertices as "not visited"
    for (int j=0; j<graph->numberVertices; j++) {
        graph->vertices[j].visited = WHITE;
    }

    currentPath = createPath(graph->numberVertices);
    bestPath = createPath(graph->numberVertices);

    currentPath->vertices[0] = start;
    currentPath->numberVertices = 1;

    bestPath->totalCost = INT_MAX;

    findShortestPath(graph, start, end);

    if (bestPath->totalCost == INT_MAX) {
        // There is no path between the start and end vertices
        free(bestPath);
        bestPath = NULL;
    }
    deletePath(currentPath);
    return bestPath;
}

//---------------------------------------------------------------------
void findShortestPath(Graph * graph, int from, int end) {
    for (int to=0; to<graph->numberVertices; to++)
    {
        if (graph->edges[from][to] > 0)
        {
            if(graph->vertices[to].visited == WHITE)
            {
                currentPath->vertices[currentPath->numberVertices] = to;
                currentPath->numberVertices = currentPath->numberVertices + 1;
                currentPath->totalCost = currentPath->totalCost + graph->edges[from][to];

                graph->vertices[to].visited = BLACK;

                if(to == end)
                {
                    if(currentPath->totalCost < bestPath->totalCost)
                    {
                        copyPath(bestPath, currentPath);
                    }
                }
                else
                {
                    findShortestPath(graph, to, end);
                }

                graph->vertices[to].visited = WHITE;

                currentPath->numberVertices--;
                currentPath->totalCost -= graph->edges[from][to];

            }
        }
    }
}


