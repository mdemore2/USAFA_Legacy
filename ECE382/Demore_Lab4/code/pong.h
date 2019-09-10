
/*******************************************
  * Author: C2C Mark Demore II
  * Created: 16 Oct 2017
  * Description: This program creates the ball structure for use in pong and etch-a-sketch implementation,
  * accompanied with collision detection functions.
  * Documentation: None
*******************************************/


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

ball_t updateEtch(ball_t ball);

char collisionXDetect(ball_t ball);

char endGame(ball_t ball);

char collisionYDetect(ball_t ball);
char collisionEtchDetect(ball_t ball);

ball_t collisionPaddle(ball_t ball, ball_t paddle);

ball_t drawPaddle(ball_t paddle);


#endif
