#include <msp430.h>
#include <pong.h>

ball_t updateBall(ball_t ball)
{
    ball.position.x += ball.velocity.x;
    ball.position.y += ball.velocity.y;
    volatile char collide = collisionDetect(ball);
    if(collide == TRUE)
    {
        ball.velocity.x = 0 - ball.velocity.x;
        ball.velocity.y = 0 - ball.velocity.y;
        updateBall(ball);
    }


    return ball;
}

char collisionDetect(ball_t ball)
{
    if(ball.position.x > SCREEN_WIDTH || ball.position.x < 0)
    {
        return TRUE;
    }
    else if(ball.position.y > SCREEN_HEIGHT || ball.position.y < 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

ball_t createBall(int xPos, int yPos, int xVel, int yVel, unsigned char radius)
{
    ball_t ball;
    ball.position.x = xPos;
    ball.position.y = yPos;
    ball.velocity.x = xVel;
    ball.velocity.y = yVel;
    ball.radius = radius;

    return ball;
}
