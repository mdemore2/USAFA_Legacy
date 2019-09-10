
/*--------------------------------------------------------------------
Name: Capt Jeff Falkinburg
Date: 20 July 2016
Course: ECE 382
File: pong.h
Event: Assignment 7 - Pong

Purp: Implements a subset of the pong game

Doc:    <list the names of the people who you helped>
        <list the names of the people who assisted you>

Academic Integrity Statement: I certify that, while others may have
assisted me in brain storming, debugging and validating this program,
the program itself is my own work. I understand that submitting code
which is the work of other individuals is a violation of the honor
code.  I also understand that if I knowingly give my original work to
another individual is also a violation of the honor code.
-------------------------------------------------------------------------*/

#ifndef _PONG_H
#define _PONG_H

#define SCREEN_WIDTH 240
#define SCREEN_HEIGHT 320

#define TRUE 1
#define FALSE 0

typedef struct {
    volatile int x;
    volatile int y;
} vector2d_t;

typedef struct {
    vector2d_t position;
    vector2d_t velocity;
    volatile unsigned char radius;
} ball_t;

ball_t createBall(int xPos, int yPos, int xVel, int yVel, unsigned char radius);

ball_t updateBall(ball_t ball);

char collisionDetect(ball_t ball);


#endif
