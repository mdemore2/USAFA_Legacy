/** GraphP.h
 * ===========================================================
 * Name:              , Spring 2017
 * Section:
 * Project: Graphs
 * Purpose: Implement a graph using arrays (an adjacency matrix)
 * ===========================================================
 */

#ifndef GRAPHP_H
#define GRAPHP_H

// State of a node during a traversal
#define WHITE  0
#define GRAY   1
#define BLACK  2

#define NO_BACK_EDGES    0
#define FOUND_BACK_EDGE  1

#define MAX_LABEL_LENGTH  10
typedef struct vertex {
    char  label[MAX_LABEL_LENGTH];
    int   visited;  // WHITE, GRAY, or BLACK
    int   discover; // a "time" value during traversals
} Vertex;

typedef struct graph {
    int      numberVertices;
    Vertex * vertices;
    int **   edges;    // 0 means no edge: >0 is the edge weight
} Graph;

typedef struct path {
    int   numberVertices; // How many vertices are in the path
    int   maxLength;      // The size of the vertices array
    int * vertices;       // An array of vertex indexes
    int   totalCost;      // The sum of the edge weights
} Path;

Graph * graphCreate(int numberNodes);
void    graphAddEdge(Graph * graph, int fromNode, int toNode, int weight);
Path  * graphFindShortestPath(Graph * graph, int start, int end);
void    printGraph(Graph * graph);

Path * createPath(int maxLength);
void   deletePath(Path *path);
void   copyPath(Path * to, Path * from);
void   printPath(Path * path);

#endif // GRAPHP_H
