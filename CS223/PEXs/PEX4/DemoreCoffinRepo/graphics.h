/** Graphics.h
 * ===========================================================
 * Name: Dr. Wayne Brown, Spring 2017
 * Section:
 * Project: PEX4
 * Purpose: The definition of functions needed to draw graphic
 *          elements on a window.
 * ===========================================================
 */

#ifndef PEX4_GRAPHICS_H
#define PEX4_GRAPHICS_H

#include <windows.h>

// An array of graphic pens -- so they can be created only once
#define SOLID_THIN_WHITE  0
#define SOLID_THIN_BLACK  1
#define SOLID_THICK_BLACK 2
#define SOLID_THIN_RED    3
#define SOLID_THICK_RED   4
#define SOLID_THIN_GREEN  5
#define NUMBER_PENS    6  // Update this if you add new pens

// An array of graphic brushes -- so they can be created only once
#define MY_BLACK_BRUSH    0
#define MY_RED_BRUSH      1
#define MY_GREEN_BRUSH    2
#define MY_WHITE_BRUSH    3
#define NUMBER_BRUSHES  4 // Update this is you add new brushes

void createGraphicsWindow(char *windowTitle,
                          WNDPROC messageFunction,
                          int startX, int startY,
                          int width, int height);
void redraw();
void clearBackground(HWND hwnd, HDC hdc, int whichPen, int whichBrush);
void drawPixel(HDC hdc, int pixelX, int pixelY, COLORREF color);
void drawLine(HDC hdc, int fromX, int fromY, int toX, int toY, int whichPen);
void drawCircle(HDC hdc, int centerX, int centerY, int radius, int whichPen, int whichBrush);
void drawText(HDC hdc, int x, int y, char *text);

#endif // PEX4_GRAPHICS_H
