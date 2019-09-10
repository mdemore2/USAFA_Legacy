//
// Created by Wayne.Brown on 4/14/2017.
//

#include "GraphA1.h"

int main() {
    Graph * graph = graphCreate(7, sizeof(int));
    graphAddEdge(graph, 'A', 'D');
    graphAddEdge(graph, 'A', 'G');
    graphAddEdge(graph, 'A', 'F');
    graphAddEdge(graph, 'C', 'B');
    graphAddEdge(graph, 'C', 'E');
    graphAddEdge(graph, 'D', 'E');
    graphAddEdge(graph, 'D', 'B');
    graphAddEdge(graph, 'E', 'A');
    graphAddEdge(graph, 'E', 'B');
    graphAddEdge(graph, 'F', 'E');
    graphAddEdge(graph, 'F', 'G');
    graphAddEdge(graph, 'G', 'C');

    graphDepthFirstTraversal(graph, 'A');
}