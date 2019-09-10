/** gameLogic.h
 * ===========================================================
 * Name: Dr. Wayne Brown, Spring 2017
 * Modified by: Demore/Coffin
 * Section: T3A
 * Project: PEX4
 * Purpose: The definition of data and functions needed to
 *          implement a Shannon Switching Game.
 * ===========================================================
 */

#ifndef GAME_LOGIC_H
#define GAME_LOGIC_H

#include "Graph.h"
#include "graphics.h"

#define FALSE  0
#define TRUE   1

#define WHITE 0
#define GRAY 1
#define BLACK 2

// The values stored in the edge adjacency matrix
#define NO_EDGE      0 // No edge exists
#define NORMAL_EDGE  1 // Normal edge
#define LOCKED_EDGE  2 // An edge selected by the "SHORT player"

// The types of graph vertices.
#define NORMAL_VERTEX        0
#define STARTING_VERTEX      1
#define ENDING_VERTEX        2

// A single vertex in a graph
typedef struct vertex {
    int x;     // (x,y) location of the vertex in the graphics window
    int y;
    int type;  // NORMAL_VERTEX, STARTING_VERTEX, or ENDING_VERTEX
} Vertex;

// A structure for transferring edge data between functions.
typedef struct edge {
    int fromVertex;
    int toVertex;
} Edge;

typedef struct path {
    int   numberVertices; // How many vertices are in the path
    int   maxLength;      // The size of the vertices array
    int * vertices;       // An array of vertex indexes
    int   totalCost;      // The sum of the edge weights
} Path;

// The two players are called "cut" and "short". The "cut" player
// removes edges from the graph. The "short" player tries to select
// edges that create a path from the starting and ending nodes.
#define CUT_PLAYER   0
#define SHORT_PLAYER 1

// Each player's turn can be made from user input (HUMAN_PLAYER)
// or by computer logic (AI_PLAYER).
#define HUMAN_PLAYER 0
#define AI_PLAYER    1

// Game status
#define GAME_UNDERWAY 0
#define SHORT_WINS    1
#define CUT_WINS      2

// Game functions
void setPlayerType(int player, int type);
void setActivePlayer(int player);
void createVertices(Graph * graph, int max_X, int max_Y,
                    int margin, int minDistance, int randomize);
void createEdges(Graph * graph, int minNumberEdges, int maxNumberEdges,
                 int windowWidth, int windowHeight, double edgeLengthPercent);
void printGraph(Graph *graph);
void drawGraph(Graph *graph, HWND hwnd, int labelVertices);
void doTurn(Graph *graph, int mouseX, int mouseY);

#endif // GAME_LOGIC_H