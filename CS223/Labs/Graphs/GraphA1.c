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
#include "GraphA1.h"

Graph * graphCreate(int numberNodes, int bytesPerNode) {
    Graph *graph = (Graph *) malloc( sizeof(Graph));

    graph->nodes = malloc( numberNodes * bytesPerNode);
    graph->edges = (char **) malloc( numberNodes * sizeof(char *));
    graph->visited = (int *) malloc((numberNodes * sizeof(int)));
    graph->numberNodes = numberNodes;

    // Create each row of the adjacency matrix
    for (int j=0; j<numberNodes; j++) {
        graph->edges[j] = (char *) malloc( numberNodes * sizeof(char));
        graph->visited[j] = 0;
    }

    // Set every edge to FALSE
    for (int row = 0; row < graph->numberNodes; row++) {
        for (int col = 0; col < graph->numberNodes; col++) {
            graph->edges[row][col] = FALSE;
        }
    }

    return graph;
}

void graphAddEdge(Graph * graph, int fromNode, int toNode) {
    // Convert the node letters into an array index
    fromNode = fromNode - 'A';
    toNode = toNode - 'A';

    if (fromNode >= 0 && fromNode <= graph->numberNodes &&
            toNode >= 0 && toNode <= graph->numberNodes) {
        graph->edges[fromNode][toNode] = TRUE;
    }
}

void graphDepthFirstTraversal(Graph * graph, int nodeLetter) {

    // Convert the node letter into an node index
    int nodeIndex = nodeLetter - 'A';

    graph->visited[nodeIndex] = GRAY;
    // visit the node
    printf("%c ", (char) nodeLetter);

    // Go depth first into the graph
    for (int to=0; to<graph->numberNodes; to++) {
        if (graph->edges[nodeIndex][to] == TRUE) {
            if(graph->visited[to] == WHITE)
            {
                graphDepthFirstTraversal(graph, 'A' + to);
            }
        }
    }
    graph->visited[nodeIndex] = BLACK;
}

void depthFirstVisit(Graph * graph,  int nodeLetter)
{
    for(int i = 0; i < graph->numberNodes; i ++)
    {
        graph->visited[i] = WHITE;
    }
    graphDepthFirstTraversal(graph, nodeLetter);

    for(int i = 0; i <graph->numberNodes;i++)
    {
        if(graph->visited[i] == WHITE)
        {
            graphDepthFirstTraversal(graph, i + 'A');
        }
    }
}


