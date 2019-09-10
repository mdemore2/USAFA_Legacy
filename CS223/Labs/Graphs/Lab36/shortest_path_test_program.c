//
// Created by Wayne.Brown on 4/14/2017.
//

#include <stdio.h>
#include "GraphP.h"

void setVertices(Graph * graph);
void setEdges(Graph * graph);

int main() {
    // Create the graph from the textbook, page 245
    int n = 7;
    Graph * graph = graphCreate(n);
    setVertices(graph);
    setEdges(graph);
    printGraph(graph);

    Path * path = graphFindShortestPath(graph, 0, 5);

    if (path != NULL) {
        printf("\nThe best path is\n");
        printPath(path);
    } else {
        printf("No path was found\n");
    }
}

void setVertices(Graph * graph) {
    Vertex * v = graph->vertices;
    for (int j=0; j<graph->numberVertices; j++) {
        sprintf(v[j].label, "%d", j);
    }
}

void setEdges(Graph * graph) {
#define NUMBER_EDGES 13
    int edges[NUMBER_EDGES][3] = { {0,3, 20},
                                   {0,6, 75},
                                   {3,6, 45},
                                   {3,1, 40},
                                   {3,5, 10},
                                   {3,4, 35},
                                   {5,4, 40},
                                   {5,2, 15},
                                   {5,1,  5},
                                   {2,4,  5},
                                   {2,6, 25},
                                   {4,6, 10},
                                   {4,1, 20}
                                  };

    for (int j=0; j<NUMBER_EDGES; j++) {
        graphAddEdge(graph, edges[j][0], edges[j][1], edges[j][2]);
    }
}