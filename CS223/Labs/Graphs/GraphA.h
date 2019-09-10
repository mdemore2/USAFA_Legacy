/** GraphA.h
 * ===========================================================
 * Name:              , Spring 2017
 * Section:
 * Project: Graphs
 * Purpose: Implement a graph using arrays (an adjacency matrix)
 * ===========================================================
 */

#ifndef GRAPHA_H
#define GRAPHA_H

#define FALSE  'f'
#define TRUE   't'

typedef struct graph {
    int      numberNodes;
    void  *  nodes;
    char **  edges;
} Graph;

Graph * graphCreate(int numberNodes, int bytesPerNode);
void    graphAddEdge(Graph * graph, int fromNode, int toNode);
void    depthFirstTraversal(Graph * graph);

#endif // GRAPHA_H
