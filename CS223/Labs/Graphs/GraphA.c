//
// Created by C19Mark.Demore on 4/17/2017.
//

#include "GraphA.h"
#include <stdio.h>
#include <stdlib.h>

Graph * graphCreate (int numberNodes, int bytesPerNode)
{
    char * row = malloc(sizeof(bytesPerNode*numberNodes));
    char ** array = malloc(sizeof(row) * numberNodes);
    Graph * graphy = malloc(sizeof(Graph));
    graphy->nodes = row;
    graphy->edges = array;
    graphy->numberNodes = numberNodes;
    return graphy;
}

void    graphAddEdge(Graph * graph, int fromNode, int toNode)
{
    if(fromNode > 0 && toNode > 0)
    {
        if(fromNode < graph->numberNodes && toNode < graph->numberNodes)
        {
            graph->edges [fromNode] [toNode] = 't';
            graph->edges [toNode] [fromNode] = 't';
        }
}

void    depthFirstTraversal(Graph * graph)
{

}

void graphSetNodeValue(Graph * the_graph, int nodeValue, int index)
{
    the_graph->nodes[index] = (void) nodeValue;
}

int main()
{
    return 0;
}