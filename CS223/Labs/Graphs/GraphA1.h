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

#define WHITE 0
#define GRAY 1
#define BLACK 2

typedef struct graph {
    int      numberNodes;
    void  *  nodes;
    char **  edges;
    int  * visited;
} Graph;


Graph * graphCreate(int numberNodes, int bytesPerNode);
void    graphAddEdge(Graph * graph, int fromNode, int toNode);
void    graphDepthFirstTraversal(Graph * graph, int nodeLetter);
void    graphBreadthFirstTraversal(Graph * graph, int nodeLetter);
void    depthFirstVisit(Graph * graph,  int nodeLetter);

#endif // GRAPHA_H
