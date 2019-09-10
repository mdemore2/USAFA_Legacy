/** Graphics.c
 * ===========================================================
 * Name: Dr. Wayne Brown, Spring 2017
 * Section:
 * Project: PEX4
 * Purpose: Implementation of functions needed to draw graphic
 *          elements on a window.
 * ===========================================================
 */

#include <stdio.h>
#include "graphics.h"

// Colors
#define WHITE  RGB(255, 255, 255)
#define BLACK  RGB(0, 0, 0)
#define RED    RGB(255, 0, 0)
#define GREEN  RGB(0, 255, 0)
#define BLUE   RGB(0, 0, 255)

// An array of graphic pens -- so they can be created only once
static HPEN pens[NUMBER_PENS];

// An array of graphic brushes -- so they can be created only once
static HBRUSH brushes[NUMBER_BRUSHES];

// This "global variable" is set by clearBackground() and used
// by redraw. Make sure that the background has been cleared at
// least once before calling redraw().
static HWND handleToWindow = NULL;

// Window constants - do not change these
#define VERTICAL_BORDERS  6
#define HORIZONTAL_BORDERS 28

// Local helper functions:
static void initializeGraphicPens();

/** -------------------------------------------------------------------
 * Create a window
 * @param windowTitle a string that will appear in the title bar
 * @param messageFunction - the message processing function
 * @param startX - the upper-left corner's x coordinate
 * @param startY - the upper-left corner's y coordinate
 * @param width - the width of the window's interior
 * @param height - the height of the window's interior
 */
void createGraphicsWindow(char *windowTitle,
                          WNDPROC messageFunction,
                          int startX, int startY,
                          int width, int height) {
    initializeGraphicPens();

    WNDCLASSW wc = {0};

    wc.style = CS_HREDRAW | CS_VREDRAW;
    wc.lpszClassName = (LPCWSTR) L"CS223";
    wc.hInstance     = NULL; // handle to instance
    wc.hbrBackground = GetSysColorBrush(COLOR_3DFACE);
    wc.lpfnWndProc   = messageFunction;
    wc.hCursor       = LoadCursor(0, IDC_ARROW);

    // Convert the ASCII string to a Unicode string (2 bytes per char)
    wchar_t unicodeTitle[1024];
    mbstowcs(unicodeTitle, windowTitle, strlen(windowTitle)+1);

    RegisterClassW(&wc);
    CreateWindowW(wc.lpszClassName, (LPCWSTR) unicodeTitle,
                  WS_TILED | WS_SYSMENU | WS_MINIMIZEBOX | WS_VISIBLE,
                  startX, startY,
                  width + VERTICAL_BORDERS,
                  height + HORIZONTAL_BORDERS, NULL, NULL, NULL, NULL);
}

/** -------------------------------------------------------------------
 * Create the pens and brushes for drawing. Pens are used to draw
 * lines. Brushes are used to fill the interior of polygons.
 */
void initializeGraphicPens() {
    pens[SOLID_THIN_WHITE]  = CreatePen(PS_SOLID, 1, WHITE);
    pens[SOLID_THIN_BLACK]  = CreatePen(PS_SOLID, 1, BLACK);
    pens[SOLID_THICK_BLACK] = CreatePen(PS_SOLID, 1, BLACK);
    pens[SOLID_THIN_RED]    = CreatePen(PS_SOLID, 1, RED);
    pens[SOLID_THICK_RED]   = CreatePen(PS_SOLID, 3, RED);
    pens[SOLID_THIN_GREEN]  = CreatePen(PS_SOLID, 1, GREEN);

    brushes[MY_BLACK_BRUSH] = CreateSolidBrush(BLACK);
    brushes[MY_RED_BRUSH]   = CreateSolidBrush(RED);
    brushes[MY_GREEN_BRUSH] = CreateSolidBrush(GREEN);
    brushes[MY_WHITE_BRUSH] = CreateSolidBrush(WHITE);
}

/** -------------------------------------------------------------------
 * Cause the window's contents to be redrawn. It actually
 * creates a new "PAINT" message and sends the message to the
 * event queue. When the event loop processes the event. The
 * window will be redrawn.
 */
void redraw() {
    InvalidateRect(handleToWindow, NULL, TRUE);
}

/** -------------------------------------------------------------------
 * Clear the background of the window by drawing a rectangle over
 * the entire area.
 * @param hwnd handle to the window
 * @param hdc handle to a device context
 * @param whichPen an index into the Pens array
 * @param whichBrush an index into the Brushes array
 */
void clearBackground(HWND hwnd, HDC hdc, int whichPen, int whichBrush) {
    // Remember the handle to the window for later use in redraw()
    handleToWindow = hwnd;

    RECT rectangle;
    GetClientRect(hwnd, &rectangle);  // returns the size of the window

    SelectObject(hdc, pens[whichPen]); // color of the rectangle's border
    SelectObject(hdc, brushes[whichBrush]);
    Rectangle(hdc, 0, 0, rectangle.right, rectangle.right);
}

/** -------------------------------------------------------------------
 * Change the color of an individual pixel.
 * @param hdc handle to a device context
 * @param pixelX the x coordinate of the pixel (from upper-left corner)
 * @param pixelY the y coordinate of the pixel (from upper-left corner)
 * @param color the RGB color to put into the pixel
 */
void drawPixel(HDC hdc, int pixelX, int pixelY, COLORREF color) {
    SetPixel(hdc, pixelX, pixelY, color);
}

/** -------------------------------------------------------------------
 * Draw a line
 * @param hdc handle to a device context
 * @param fromX starting x coordinate
 * @param fromY starting y coordinate
 * @param toX ending x coordinate
 * @param toY ending y coordinate
 * @param whichPen an index into the Pens array
 */
void drawLine(HDC hdc, int fromX, int fromY, int toX, int toY, int whichPen) {
    SelectObject(hdc, pens[whichPen]);
    MoveToEx(hdc, fromX, fromY, NULL);
    LineTo(hdc, toX, toY);
}

/** -------------------------------------------------------------------
 * Draw a circle
 * @param hdc handle to a device context
 * @param centerX center x coordinate
 * @param centerY center y coordinate
 * @param radius radius of the circle
 * @param whichPen an index in to the Pens array
 * @param whichBrush an index in the Brushes array
 */
void drawCircle(HDC hdc, int centerX, int centerY, int radius, int whichPen, int whichBrush) {
    int upperLeftX = centerX - radius;
    int upperLeftY = centerY - radius;
    int lowerRightX = centerX + radius;
    int lowerRightY = centerY + radius;
    SelectObject(hdc, pens[whichPen]);
    SelectObject(hdc, brushes[whichBrush]);
    Ellipse(hdc, upperLeftX, upperLeftY, lowerRightX, lowerRightY);
}

/** -------------------------------------------------------------------
 * Draw text
 * @param hdc handle to a device context
 * @param x the x coordinate of the upper-left corner of the text
 * @param y the y coordinate of the upper-left corner of the text
 * @param text the text to display
 */
void drawText(HDC hdc, int x, int y, char *text) {
    // NOTE: For long strings the rectangle may be too small!
    RECT rectangle = {x, y, x+200, y+20};
    DrawText(hdc, text, (int) strlen(text), &rectangle, DT_TOP | DT_LEFT);
}