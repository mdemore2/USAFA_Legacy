/** PEX4_Shannon_switching_game.c
 * ===========================================================
 * Name: Dr. Wayne Brown, Spring 2017
 * Modified by: <YOUR NAME HERE>
 * Section:
 * Project: PEX4
 * Purpose: A Shannon Switching Game
 * ===========================================================
 */

#include <windows.h>
#include <WindowsX.h>
#include <stdio.h>
#include "graphics.h"
#include "Graph.h"
#include "gameLogic.h"

// Constants that control the game window. Change as desired.
#define WINDOW_UPPER_LEFT_CORNER_X      0
#define WINDOW_UPPER_LEFT_CORNER_Y      0
#define WINDOW_WIDTH                  800
#define WINDOW_HEIGHT                 500

// Constants that control the graph characteristics. Change as desired.
#define NUM_GRAPH_NODES                 11
#define MIN_DISTANCE_BETWEEN_VERTICES  40
#define MARGIN                         30
#define MINIMUM_EDGES_PER_VERTEX        4
#define MAXIMUM_EDGES_PER_VERTEX        7
// Restrict the length of graph edges to a certain percentage of
// the window's maximum dimension.
#define EDGE_LENGTH_PERCENT           0.28
#define DISPLAY_VERTEX_INDEXES        TRUE
#define RANDOMIZE_VERTEX_LOCATIONS    FALSE

// Local function definitions
int runEventLoop();
LRESULT CALLBACK WndProc(HWND, UINT, WPARAM, LPARAM);

// Global variable that is needed by WndProc.
Graph * graph;

/** -------------------------------------------------------------------
 * main function; creates a graph, adds vertices and edges,
 * creates a main window, and starts the GUI event loop.
 * @return error code; 0 means no errors.
 */
int main() {
    // Create a graph data structure.
    graph = graphCreate(NUM_GRAPH_NODES, sizeof(Vertex));

    // Fill the graph with Shannon Switching Game data
    createVertices(graph, WINDOW_WIDTH, WINDOW_HEIGHT, MARGIN,
                   MIN_DISTANCE_BETWEEN_VERTICES,
                   RANDOMIZE_VERTEX_LOCATIONS);
    createEdges(graph, MINIMUM_EDGES_PER_VERTEX, MAXIMUM_EDGES_PER_VERTEX,
                WINDOW_WIDTH, WINDOW_HEIGHT, EDGE_LENGTH_PERCENT);
    printGraph(graph);

    // Set the player types
    setPlayerType(CUT_PLAYER, HUMAN_PLAYER);
    setPlayerType(SHORT_PLAYER, HUMAN_PLAYER);

    // Set who goes first
    int playa = rand() % 2;
    setActivePlayer(playa);

    // Create a graphics window
    createGraphicsWindow("Shannon Switching Game", WndProc,
                         WINDOW_UPPER_LEFT_CORNER_X,
                         WINDOW_UPPER_LEFT_CORNER_Y,
                         WINDOW_WIDTH, WINDOW_HEIGHT);

    // Run the GUI (Graphical User Interface) event loop
    return runEventLoop();
}

/** -------------------------------------------------------------------
 * Run the GUI event loop, which receives event messages from the
 * operating system and sends them to WndProc for processing.
 * @return the status from the final message
 */
int runEventLoop() {
    MSG  msg;

    while (GetMessage(&msg, NULL, 0, 0)) {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }

    return (int) msg.wParam;
}

/** -------------------------------------------------------------------
 * Process event messages.
 * @param hwnd handle to the window
 * @param msg the message to process
 * @param wParam an event parameter
 * @param lParam an even parameter
 * @return the status of processing the event
 */
LRESULT CALLBACK WndProc(HWND hwnd, UINT msg,
                         WPARAM wParam, LPARAM lParam) {
    int mouseX, mouseY; // The location of the mouse on mouse clicks

    // Deal with the application specific messages
    switch(msg) {
        case WM_PAINT:
            drawGraph(graph, hwnd, DISPLAY_VERTEX_INDEXES);
            break;

        case WM_LBUTTONUP:
            mouseX = GET_X_LPARAM(lParam);
            mouseY = GET_Y_LPARAM(lParam);
            //printf("Mouse click %3d %3d\n", mouseX, mouseY);
            doTurn(graph, mouseX, mouseY);
            break;

        case WM_DESTROY:
            PostQuitMessage(0);
            return 0;

        default: // Do nothing
            ;
    }

    // This handles all the normal windows behavior, like dragging the window.
    return DefWindowProcW(hwnd, msg, wParam, lParam);
}
