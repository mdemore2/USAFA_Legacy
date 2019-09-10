/** gameLogic.c
 * ===========================================================
 * Name: Dr. Wayne Brown, Spring 2017
 * Modified by: Demore/Coffin
 * Section: T3A
 * Project: PEX4
 * Purpose: The implementation of functions needed to
 *          create a Shannon Switching Game.
 * Documentation: C3C Spencer Adolph said I should use a global variable for end status
 * ===========================================================
 */
// Donny wuz here

#include <stdio.h>
#include <time.h>
#include <math.h>
#include "gameLogic.h"
#include <limits.h>

#define MAXIMUM_TRIES_TO_SET_LOCATION     1000
#define MAXIMUM_TRIES_TO_CREATE_EDGE      1000
#define MAXIMUM_TRIES_TO_FIND_RANDOM_EDGE 5000
#define VERTEX_DRAW_RADIUS  5
#define CLICK_TOLERANCE 5.0
#define OVER -1

// The type of the two game players.
static int playerType[2] = {HUMAN_PLAYER, HUMAN_PLAYER};
static char * playerTypeNames[4] = {" (Human)", " (AI)", "(win)", "(win)"};


static int activePlayer = CUT_PLAYER;
static char * activePlayerName[] = { "Cut's turn", "Short's turn", "Cut Wins", "Short Wins"};

// Local functions
static void setLocation(Vertex *vertex, int width, int height, int margin);
static int distance(Vertex *v1, Vertex *v2);
static int someVerticesTooClose(Vertex *vertices, int last, int minimumDistance);
static int compareVertices(const void * e1, const void * e2);
static int degree(Graph * graph, int index);
static void findEdge(Graph *graph, int mouseX, int mouseY, Edge *edge);
static int humanPlayer(Graph *graph, int mouseX, int mouseY);
static int aiPlayer(Graph * graph);

//static int getPath(Graph * graph);
//static int checkWin(Graph * graph);
void graphDepthFirstTraversal(Graph * graph, int root);

Path * createPath(int maxLength);
Path  * graphFindShortestPath(Graph * graph, int start, int end);
void findShortestPath(Graph * graph, int from, int end);
void deletePath(Path *path);
void copyPath(Path * to, Path * from);

void findLockedPath(Graph * graph, int from, int end);
Path  * graphFindLockedPath(Graph * graph, int start, int end);

// Vertices are sorted according to their distance from the origin (0,0)
static Vertex origin = {0, 0, 0};

/** -------------------------------------------------------------------
 * Set the type of player.
 * @param player Either CUT_PLAYER or SHORT_PLAYER
 * @param type Either HUMAN_PLAYER or AI_PLAYER
 */
void setPlayerType(int player, int type) {
    if ( (player == CUT_PLAYER || player == SHORT_PLAYER) &&
         (type == HUMAN_PLAYER || type == AI_PLAYER) ) {
        playerType[player] = type;
    } else{
        playerType[player] = type;
    }
}

/** -------------------------------------------------------------------
 * Set the active player. This should be called only once at
 * the start of the game to determine who goes first.
 * @param player Either CUT_PLAYER or SHORT_PLAYER
 */
void setActivePlayer(int player) {
    if ( player == CUT_PLAYER || player == SHORT_PLAYER ) {
        activePlayer = player;
    }
    else
    {
        //end game
        activePlayer = player;
    }
}

/** -------------------------------------------------------------------
 * Create a set of random vertices for the game graph. The location
 * of each vertex must meet certain constraints:
 *    1) It must be inside the game window.
 *    2) It must be "margin" pixels aways from the window borders.
 *    3) It must be "minDistance" away from all other vertices.
 * @param graph the graph to modify
 * @param max_X the width of the window along the x axis
 * @param max_Y the height of the window along the y axis
 * @param margin the number of pixels to keep clear along all borders
 * @param minDistance the minimum distance between any two vertices
 * @param randomize if TRUE, the location of the vertices is random.
 *                  if FALSE, your get the same graph every time.
 */
void createVertices(Graph *graph, int max_X, int max_Y,
                    int margin, int minDistance, int randomize) {

    // Create a local variable to point to the vertex array to simplify the code.
    Vertex * vertices = (Vertex *) graph->vertices;
    if (randomize) {
        // Use the current time to randomize the random number generator.
        time_t t;
        srand((unsigned) time(&t));
    }

    // Set a random location for the first vertex.
    setLocation(vertices, max_X, max_Y, margin);

    // Set a random location for all the other vertices, but make sure they are
    // not too close to any of the other vertices that have already been created.
    int numberTries;
    int tooClose;
    for (int j = 1; j < graph->numberVertices; j++) {
        numberTries = 0;
        tooClose = TRUE;
        while (tooClose && numberTries < MAXIMUM_TRIES_TO_SET_LOCATION) {
            numberTries++;
            setLocation(vertices+j, max_X, max_Y, margin);

            tooClose = someVerticesTooClose(vertices, j, minDistance);
        }
        if (numberTries >= MAXIMUM_TRIES_TO_SET_LOCATION) {
            printf("ERROR in createVertices. Too many tries to create a new vertex.");
            exit(1);
        }
    }

    // Sort the vertices based on their distance from the origin (0,0)
    qsort(graph->vertices, (size_t) graph->numberVertices, sizeof(Vertex), compareVertices);

    // Make the first and last vertex the starting and ending vertices
    // of the Shannon switching game.
    vertices[0].type = STARTING_VERTEX;
    vertices[graph->numberVertices-1].type = ENDING_VERTEX;
}

/** -------------------------------------------------------------------
 * Set the location of a vertex.
 * @param vertex the vertex to change
 * @param width the width of the window
 * @param height the height of the window
 * @param margin the margins around the borders
 */
void setLocation(Vertex *vertex, int width, int height, int margin) {
    vertex->x = (rand() % (width  - (2 * margin))) + margin;
    vertex->y = (rand() % (height - (2 * margin))) + margin;
    vertex->type = NORMAL_VERTEX;
}

/** -------------------------------------------------------------------
 * Check to verify that a vertex is not too close to any of the other
 * vertices in the graph.
 * @param vertices the array of vertices
 * @param last the vertex to check
 * @param minimumDistance the minimum distance between two vertices
 * @return TRUE if the distance between vertices[last] and every
 *         other vertex is greater than minimumDistance.
 *         return FALSE otherwise.
 */
int someVerticesTooClose(Vertex * vertices, int last, int minimumDistance) {
    // Check to make sure vertices[last] is not too close to other vertices
    Vertex * lastVertex = vertices + last;
    int k = 0;
    while (k < last && distance(lastVertex, vertices+k) > minimumDistance) {
        k++;
    }
    return k < last; // TRUE if one vertex is less than minimumDistance away.
}

/** -------------------------------------------------------------------
 * Calculate the distance between two vertices
 * @param v1 vertex 1
 * @param v2 vertex 2
 * @return the distance between the two vertices
 */
int distance(Vertex *v1, Vertex *v2) {
    double dx = (double) v1->x - (double) v2->x;
    double dy = (double) v1->y - (double) v2->y;
    return (int) (sqrt(dx*dx + dy*dy));
}

/** -------------------------------------------------------------------
 * Compare two vertices. This is used by qsort to sort the vertices array.
 * @param e1 a pointer to a vertex
 * @param e2 a pointer to a vertex
 * @return -1 if e1 < e1; 0 if e1 == e2, +1 if e1 > e2
 */
int compareVertices(const void * e1, const void * e2) {
    Vertex * v1 = (Vertex *) e1;
    Vertex * v2 = (Vertex *) e2;
    int dist1 = distance(v1, &origin);
    int dist2 = distance(v2, &origin);
    if (dist1 < dist2)       return -1;
    else if (dist1 == dist2) return 0;
    else                     return 1;
}

/** -------------------------------------------------------------------
 * Create a set of random edges for a graph that meet the following
 * constraints:
 *   1) Each vertex can have [minNumberEdges, maxNumberEdges] edges
 *   2) Each edge must have a length that is less than
 *      edgeLengthPercent*max(windowWidth, windowHeight)
 * @param graph the graph to modify
 * @param minNumberEdges the minimum number of edges that each vertex must have
 * @param maxNumberEdges the maximum number of edges that each vertex can have
 * @param windowWidth the width of the game window
 * @param windowHeight the height of the game window
 * @param edgeLengthPercent limits the length of edges in the graph
 */
void createEdges(Graph * graph, int minNumberEdges, int maxNumberEdges,
                 int windowWidth, int windowHeight, double edgeLengthPercent) {
    Vertex * vertices = (Vertex *) graph->vertices;

    // The number of edges for each vertex is random within a range
    int edgeRange = (maxNumberEdges - minNumberEdges) + 1;
    int existingEdges;
    int desiredEdges;
    int edgesNeeded;
    int toVertex;

    // Restrict the edges to the close vertices by restricting the length
    // of an edge.
    int maxEdgeLength;
    if (windowWidth > windowHeight) {
        maxEdgeLength = (int) (windowWidth * edgeLengthPercent);
    } else {
        maxEdgeLength = (int) (windowHeight * edgeLengthPercent);
    }

    for (int nodeIndex = 0; nodeIndex < graph->numberVertices; nodeIndex++) {
        existingEdges = degree(graph, nodeIndex);
        desiredEdges = (rand() % edgeRange) + minNumberEdges;
        edgesNeeded = desiredEdges - existingEdges;
        for (int j = 0; j < edgesNeeded; j++) {
            toVertex = nodeIndex;
            int tries = 0;
            while (tries < MAXIMUM_TRIES_TO_CREATE_EDGE &&
                   toVertex == nodeIndex) {
                toVertex = rand() % graph->numberVertices;
                if (toVertex != nodeIndex) {
                    int existingEdge = graphGetEdge(graph, nodeIndex, toVertex);
                    if (existingEdge == NO_EDGE &&
                        distance(vertices + nodeIndex, vertices + toVertex) <= maxEdgeLength) {
                        break;
                    }
                }
                tries++;
            }
            if (tries > MAXIMUM_TRIES_TO_CREATE_EDGE) {
                printf("Error in createEdges. The maximum number of tries was exceeded.\n");
                exit(1);
            }
            graphSetEdge(graph, nodeIndex, toVertex, NORMAL_EDGE);
        }
    }
}

/** -------------------------------------------------------------------
 * Calculate the number of edges that are connected to a specific vertex.
 * @param graph the graph
 * @param index which vertex, an array index [0, graph->numberNodes-1]
 * @return the number of edges leaving vertex[index]
 */
int degree(Graph * graph, int index) {
    int count = 0;
    for (int j = 0; j < graph->numberVertices; j++) {
        if (graph->edges[index][j] > NO_EDGE) {
            count++;
        }
    }
    return count;
}


/** -------------------------------------------------------------------
 * Print the value that define a graph. Great for debuggin!
 * @param graph the graph
 */
void printGraph(Graph *graph) {
    Vertex * vertices = (Vertex *) graph->vertices;
    for (int j = 0; j < graph->numberVertices; j++){
        printf("VERTEX %3d:   X=%4d    Y=%4d  TYPE=%1d\n",
               j, vertices[j].x, vertices[j].y, vertices[j].type);
    }

    for (int j = 0; j < graph->numberVertices; j++){
        printf("FROM %d   TO: ", j);
        for (int k = 0; k < graph->numberVertices; k++) {
            printf(" %3d", graph->edges[j][k]);
        }
        printf("\n");
    }
}

/** -------------------------------------------------------------------
 * Draw the graph on the window.
 * @param graph the graph
 * @param hwnd handle to the window where the graph is to be drawn
 * @param labelVertices if TRUE, the array index of each vertex is displayed
 */
void drawGraph(Graph *graph, HWND hwnd, int labelVertices) {
    PAINTSTRUCT ps;
    HDC hdc = BeginPaint(hwnd, &ps);
    int brush;
    int pen;
    char textString[40];
    Vertex * vertices = (Vertex *) graph->vertices;

    clearBackground(hwnd, hdc, SOLID_THIN_WHITE, MY_WHITE_BRUSH);

    // Display the player's name and the player's type in the upper-left corner.
    if(activePlayer > -1)
    {
        strcpy(textString, activePlayerName[activePlayer]);
        strcat(textString, playerTypeNames[playerType[activePlayer]]);
        drawText(hdc, 3, 3, textString);
    }


    char cutWin[20] = "Cut wins!";
    char shortWin[20] = "Short wins!";
    char invalid[20] = "Game board invalid";
    if(activePlayer == -1)
    {
        drawText(hdc,10,10,shortWin);
    }
    if(activePlayer == -2)
    {
        drawText(hdc,10,10,cutWin);
    }
    if(activePlayer == -3)
    {
        drawText(hdc,10,10,invalid);

    }

    // Draw the edges
    for (int from = 0; from < graph->numberVertices; from++) {
        for (int to = from+1; to < graph->numberVertices; to++) {
            if (graph->edges[from][to] > NO_EDGE) {
                if (graph->edges[from][to] == LOCKED_EDGE) {
                    // Draw a locked edge
                    pen = SOLID_THICK_RED;
                } else {
                    // Draw a normal edge
                    pen = SOLID_THIN_BLACK;
                }
                drawLine(hdc, vertices[from].x, vertices[from].y,
                              vertices[to].x,   vertices[to].y, pen);
            }
        }
    }

    // Draw the vertices
    for (int j = 0; j < graph->numberVertices; j++){
        if (vertices[j].type == NORMAL_VERTEX) {
            pen = SOLID_THIN_BLACK;
            brush = MY_BLACK_BRUSH;
        } else { // vertices[j].type == STARTING_VERTEX
            pen = SOLID_THIN_GREEN;
            brush = MY_GREEN_BRUSH;
        }

        drawCircle(hdc, vertices[j].x, vertices[j].y, VERTEX_DRAW_RADIUS, pen, brush);

        if (labelVertices) {
            sprintf(textString, "%d", j);
            drawText(hdc, vertices[j].x-20, vertices[j].y-20, textString);
        }
    }

    EndPaint(hwnd, &ps);
}

/** -------------------------------------------------------------------
 * Determine if a mouse click has selected a specific graph edge
 * @param x1 the starting coordinate (x1,y1) of the edge
 * @param y1
 * @param x2 the ending coordinate (x2,y2) of the edge
 * @param y2
 * @param mouseX the location of the mouse (mouseX, mouseY)
 * @param mouseY
 * @return TRUE if the mouse location is within CLICK_TOLERANCE pixels
 *         of any part of the edge. Return FALSE otherwise.
 */
int edgeClicked(int x1, int y1, int x2, int y2, int mouseX, int mouseY){
    //double d = 10000.0;
    double onX, onY;  // The projection of the mouse onto the line segment
    double t; // parametric parameter for a line segment from (x1,y1) to (x2,y2)

    double dx = x2 - x1;
    double dy = y2 - y1;
    t=((mouseX-x1)*(x2-x1)+(mouseY-y1)*(y2-y1))/(dx*dx + dy*dy);
    if (t < 0 || t > 1.0) {
        // The projected point is not on the line segment
        return FALSE;
    } else {
        // Calculate the projected point.
        onX = x1 + dx * t;
        onY = y1 + dy * t;

        // Find the distance from the mouse to the projected point.
        double dx2 = mouseX - onX;
        double dy2 = mouseY - onY;
        double dist = sqrt(dx2 * dx2 + dy2 * dy2);

        return dist <= CLICK_TOLERANCE;
    }
}

/** -------------------------------------------------------------------
 * Find an edge that is within CLICK_TOLERANCE of the mouse location.
 * @param graph the graph
 * @param mouseX the location of the mouse (mouseX, mouseY)
 * @param mouseY
 * @param edge output of the function. If the edge is (-1,-1) then
 *             no edge was found. If the edge is (A,B) on return
 *             then the edge that goes from node A to node B was
 *             within CLICK_TOLERANCE of the mouse location.
 */
void findEdge(Graph *graph, int mouseX, int mouseY, Edge *edge) {

    // Assume that no edge can be found
    edge->fromVertex = -1;
    edge->toVertex = -1;

    Vertex * vertices = (Vertex *) graph->vertices;

    // Search all the edges and find the closest one
    for (int from = 0; from < graph->numberVertices; from++) {
        for (int to = 0; to < graph->numberVertices; to++) {
            if (graph->edges[from][to] == NORMAL_EDGE) {
                if (edgeClicked(vertices[from].x, vertices[from].y,
                               vertices[to].x,   vertices[to].y,
                               mouseX, mouseY) ) {
                    //printf("Found %3d %3d\n", from, to);
                    edge->fromVertex = from;
                    edge->toVertex = to;
                    return;
                }
            }
        }
    }
}

/** -------------------------------------------------------------------
 * Take a turn of the game by a human player. The location of the
 * user's mouse click is used to detemine the edge that is changed.
 * @param graph the graph
 * @param mouseX the location of the mouse (mouseX, mouseY)
 * @param mouseY
 * @return TRUE if the turn was taken. Return FALSE if the turn
 *         was not taken (e.g., if the user did not select an edge.)
 */
int humanPlayer(Graph *graph, int mouseX, int mouseY) {
    Edge edge;
    findEdge(graph, mouseX, mouseY, &edge);

    if (edge.fromVertex == -1) {
        // No edge was found; therefore this turn still needs
        // to be made.
        return FALSE;
    } else {
        if (activePlayer == SHORT_PLAYER) {
            graphSetEdge(graph, edge.fromVertex, edge.toVertex, LOCKED_EDGE);
        } else if(activePlayer == CUT_PLAYER) { // activePlayer == CUT_PLAYER
            graphSetEdge(graph, edge.fromVertex, edge.toVertex, NO_EDGE);
        }
        return TRUE;
    }
}

/** -------------------------------------------------------------------
 * Make a move for an AI player.
 * @param graph the graph
 * @return TRUE if the turn was taken. Return FALSE if the turn
 *         was not taken.
 */
// each player and add intelligence to how it selects an edge.
int aiPlayer(Graph * graph) {
    // Count the number of edges
    int tries = 0;
    int from = 0;
    int to = 0;
//    while (tries < MAXIMUM_TRIES_TO_FIND_RANDOM_EDGE) {
//        // Select a random edge
//        from = rand() % graph->numberVertices;
//        to = rand() % graph->numberVertices;
//        if (graph->edges[from][to] == NORMAL_EDGE) {
//            break;
//        }
//        tries++;
//    }
//    if (tries >= MAXIMUM_TRIES_TO_FIND_RANDOM_EDGE) {
//        printf("AI failed to find a random edge.\n");
//        return FALSE;
//    }
    Path * pathy = NULL;
    pathy = graphFindShortestPath(graph, 0, graph->numberVertices-1);
    for(int i = 1; i < pathy->numberVertices;i++)
    {
        if(graph->edges[pathy->vertices[i-1]] [pathy->vertices[i]] == 1)
        {
            from = i-1;
            to = i;
            break;
        }
    }

    // Either cut or lock the edge
    if (activePlayer == SHORT_PLAYER) {
        graphSetEdge(graph, from, to, LOCKED_EDGE);
    } else if(activePlayer == CUT_PLAYER) { // activePlayer == CUT_PLAYER
        graphSetEdge(graph, from, to, NO_EDGE);
    } else{
        //do nothing
    }

    return TRUE;
}
/** -------------------------------------------------------------------
 * Take one turn in the Shannon Switching game. If the turn was successful,
 * the active player changes to the other player and the window is redrawn.
 * If the turn was not taken, the active player is unchanged and the window
 * is not redrawn.
 * @param graph the graph
 * @param mouseX the location of the mouse (mouseX, mouseY)
 * @param mouseY
 */
void doTurn(Graph *graph, int mouseX, int mouseY) {
Path * pathy = NULL;

        int turnIsDone = FALSE;

        if (playerType[activePlayer] == HUMAN_PLAYER) {
            turnIsDone = humanPlayer(graph, mouseX, mouseY);
        } else if(playerType[activePlayer] == AI_PLAYER) {
            turnIsDone = aiPlayer(graph);
        }

        if(turnIsDone) {

           pathy = graphFindShortestPath(graph,0,graph->numberVertices-1);
//            for (int j=0; j < pathy->numberVertices-1; j++) {
//                printf("%d\n",pathy->vertices[j]);
//            }
//            if (getPath(graph) == TRUE){
//                setActivePlayer(1-activePlayer);
//                //gamestatus = OVER;
//            }
//            else if(checkWin(graph)== TRUE){
//                setActivePlayer(-1);
//            }
//            else{
//                setActivePlayer(-2);
//            }
            if(pathy == NULL)
            {
              setActivePlayer(-2);  //cut wins
            } else{
                pathy = graphFindLockedPath(graph,0,graph->numberVertices-1);

                if(pathy == NULL)
                {
                    setActivePlayer(1-activePlayer);    //continue
                } else{
                    setActivePlayer(-1);    //short wins
                }
            }

            redraw();
        }




  }

Path * createPath(int maxLength) {
    Path *path = (Path *) malloc(sizeof(Path));

    path->numberVertices = 0;
    path->maxLength = maxLength;
    path->vertices = (int *) malloc( sizeof(int) * maxLength);
    path->totalCost = 0;

    return path;
}

static Path * currentPath = NULL;
static Path * bestPath = NULL;
Path  * graphFindShortestPath(Graph * graph, int start, int end) {
    // Mark all the vertices as "not visited"

    graphDepthFirstTraversal(graph, 0);
    for (int j=0; j<graph->numberVertices; j++) {
        graph->visited[j] = WHITE;
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

Path  * graphFindLockedPath(Graph * graph, int start, int end) {
    // Mark all the vertices as "not visited"

    graphDepthFirstTraversal(graph, 0);
    for (int j=0; j<graph->numberVertices; j++) {
        graph->visited[j] = WHITE;
    }

    currentPath = createPath(graph->numberVertices);
    bestPath = createPath(graph->numberVertices);

    currentPath->vertices[0] = start;
    currentPath->numberVertices = 1;

    bestPath->totalCost = INT_MAX;

    findLockedPath(graph, start, end);

    if (bestPath->totalCost == INT_MAX) {
        // There is no path between the start and end vertices
        free(bestPath);
        bestPath = NULL;
    }
    deletePath(currentPath);
    return bestPath;
}

void findShortestPath(Graph * graph, int from, int end) {
    for (int to=0; to<graph->numberVertices; to++)
    {
        if (graph->edges[from][to] > 0)
        {
            if(graph->visited[to] == WHITE)
            {
                currentPath->vertices[currentPath->numberVertices] = to;
                currentPath->numberVertices = currentPath->numberVertices + 1;
                currentPath->totalCost = currentPath->totalCost + graph->edges[from][to];

                graph->visited[to] = BLACK;

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

                graph->visited[to] = WHITE;

                currentPath->numberVertices--;
                currentPath->totalCost -= graph->edges[from][to];

            }
        }
    }
}

void findLockedPath(Graph * graph, int from, int end) {
    for (int to=0; to<graph->numberVertices; to++)
    {
        if (graph->edges[from][to] > 1)
        {
            if(graph->visited[to] == WHITE)
            {
                currentPath->vertices[currentPath->numberVertices] = to;
                currentPath->numberVertices = currentPath->numberVertices + 1;
                currentPath->totalCost = currentPath->totalCost + graph->edges[from][to];

                graph->visited[to] = BLACK;

                if(to == end)
                {
                    if(currentPath->totalCost < bestPath->totalCost)
                    {
                        copyPath(bestPath, currentPath);
                    }
                }
                else
                {
                    findLockedPath(graph, to, end);
                }

                graph->visited[to] = WHITE;

                currentPath->numberVertices--;
                currentPath->totalCost -= graph->edges[from][to];

            }
        }
    }
}

void deletePath(Path *path) {
    free(path->vertices);
    free(path);
}

void copyPath(Path * to, Path * from) {
    to->numberVertices = from->numberVertices;
    to->maxLength      = from->maxLength;
    memcpy(to->vertices, from->vertices, sizeof(int) * from->maxLength);
    to->totalCost      = from->totalCost;
}

//int getPath(Graph * graph)  //check to see if path to end node still exists
//{
//    //DO Dijkstra's here plz
//    graphDepthFirstTraversal(graph,0);      //get distance values
//
//    int * Q = malloc(sizeof(int)*graph->numberVertices);
//    int * dist = malloc(sizeof(Q));
//    int * prev = malloc(sizeof(Q));
//
//    for(int i = 0; i < graph->numberVertices; i++)
//    {
//        dist[i] = graph->distance[0] [i];
//        prev[i] = -1;
//        Q[i] = 1;
//    }
//
//    dist[0] = 0;
//    int u = 0;
//    int qEmpty = FALSE;
//    int min = INT_MAX;
//    int alt = 0;
//
//
//    while(qEmpty == FALSE)
//    {
//
//        for(int j = 0; j < graph->numberVertices; j++)
//        {
//            if(Q[u] == 0)
//            {
//                if(u > graph->numberVertices-1)
//                {
//                    u = 0;
//                }
//                else{
//                    u++;
//                }
//            }
//            if(Q[j] > 0)
//            {
//                if(dist[j] < dist[u])
//                {
//                    u = j;
//                }
//            }
//
//        }
//
//        Q[u] = 0;
//
//        for(int k = 0; k < graph->numberVertices; k++)
//        {
//            //alt  = INT_MAX;
//            if(graphGetEdge(graph,u,k) > 0) {
//                alt = dist[u] + 1;
//                if (alt < dist[k]) {
//                    dist[k] = alt;
//                    prev[k] = u;
//                }
//            }
//        }
//
//        //check if q empty yet
//        qEmpty = TRUE;
//        for(int i = 0; i < graph->numberVertices; i++)
//        {
//            if(Q[i] > 0)
//            {
//                qEmpty = FALSE;
//            }
//        }
//
//    }
//
//    //check if path complete
//    int point = (graph->numberVertices-1);
//    int total = 0;
//    for(int count = 0; count < graph->numberVertices; count ++)
//    {
//        total += dist[point];
//        point = prev[point];
//        if(point < 1)
//        {
//            if(point == 0)
//            {
//                return TRUE;
//            } else{
//                //setActivePlayer(-1);
//                return FALSE;
//            }
//
//        }
//    }
//    return FALSE;
//}

void graphDepthFirstTraversal(Graph * graph, int root) {

    graph->visited[root] = GRAY;
    // visit the node
    //printf("%d\n", root);
    int dist;
    // Go depth first into the graph
    for (int to=0; to<graph->numberVertices; to++) {
        dist = 0;
        if (graph->edges[root][to] == TRUE) {
            if(graph->visited[to] == WHITE)
            {
                dist++;
                graphDepthFirstTraversal(graph, to);
            }
            graph->distance[root] [to] = dist;
        }
    }
    graph->visited[root] = BLACK;
}

//int checkWin(Graph * graph) //check if locked path exists
//{
//    //DO Dijkstra's here plz
//    graphDepthFirstTraversal(graph,0);      //get distance values
//
//    int * Q = malloc(sizeof(int)*graph->numberVertices);
//    int * dist = malloc(sizeof(Q));
//    int * prev = malloc(sizeof(Q));
//
//    for(int i = 0; i < graph->numberVertices; i++)
//    {
//        dist[i] = graph->distance[0] [i];
//        prev[i] = -1;
//        Q[i] = 1;
//    }
//
//    dist[0] = 0;
//    int u = 0;
//    int qEmpty = FALSE;
//    int min = INT_MAX;
//    int alt = 0;
//
//
//    while(qEmpty == FALSE)
//    {
//
//        for(int j = 0; j < graph->numberVertices; j++)
//        {
//            if(Q[u] == 0)
//            {
//                if(u > graph->numberVertices-1)
//                {
//                    u = 0;
//                }
//                else{
//                    u++;
//                }
//            }
//            if(Q[j] > 0)
//            {
//                if(dist[j] < dist[u])
//                {
//                    u = j;
//                }
//            }
//
//        }
//
//        Q[u] = 0;
//
//        for(int k = 0; k < graph->numberVertices; k++)
//        {
//            //alt  = INT_MAX;
//            if(graphGetEdge(graph,u,k) > 1) {
//                alt = dist[u] + 1;
//                if (alt < dist[k]) {
//                    dist[k] = alt;
//                    prev[k] = u;
//                }
//            }
//        }
//
//        //check if q empty yet
//        qEmpty = TRUE;
//        for(int i = 0; i < graph->numberVertices; i++)
//        {
//            if(Q[i] > 0)
//            {
//                qEmpty = FALSE;
//            }
//        }
//
//    }
//
//    //check if path complete
//    int point = (graph->numberVertices-1);
//    int total = 0;
//    for(int count = 0; count < graph->numberVertices; count ++)
//    {
//        total += dist[point];
//        point = prev[point];
//        if(point < 1)
//        {
//            if(point == 0)
//            {
//                return TRUE;
//            }
//
//        }
//    }
//    return FALSE;
//}