
/*******************************************
  * Author: C2C Mark Demore II
  * Created: 16 Oct 2017
  * Description: This program handles the ball structure for use in pong and etch-a-sketch implementation,
  * accompanied with collision detection functions.
  * Documentation: None
*******************************************/

#include <msp430.h>
#include <pong.h>
//#include <colors.h>

ball_t updateBall(ball_t ball)
{
    ball.position.x += ball.velocity.x;
    ball.position.y += ball.velocity.y;
    volatile char collide = collisionXDetect(ball);
    if(collide == TRUE)
    {
        ball.velocity.x = 0 - ball.velocity.x;
        ball = updateBall(ball);
        collide == FALSE;
    }

    collide = collisionYDetect(ball);
    if(collide == TRUE)
    {
        ball.velocity.y = 0 - ball.velocity.y;
        ball = updateBall(ball);
    }



    return ball;
}

ball_t updateEtch(ball_t ball)
{
    ball.position.x += ball.velocity.x;
    ball.position.y += ball.velocity.y;
    volatile char collide = collisionXDetect(ball);
    if(collide == TRUE)
    {
        ball.velocity.x = 0 - ball.velocity.x;
        ball = updateBall(ball);
        collide == FALSE;
    }

    collide = collisionEtch(ball);
    if(collide == TRUE)
    {
        ball.velocity.y = 0 - ball.velocity.y;
        ball = updateBall(ball);
    }



    return ball;
}

char collisionXDetect(ball_t ball)
{
    if(ball.position.x > (SCREEN_WIDTH-ball.radius-1) || ball.position.x < 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
char collisionYDetect(ball_t ball)
{
   if(ball.position.y > (SCREEN_HEIGHT-ball.radius))
   {
       return TRUE;
   }
   /*if(ball.position.y < 0)
   {
       endGame();
   }*/
   else
   {
       return FALSE;
   }
}


char collisionEtch(ball_t ball)
{
   if(ball.position.y > (SCREEN_HEIGHT-ball.radius)|| ball.position.y < 0)
   {
       return TRUE;
   }
   else
   {
       return FALSE;
   }
}

ball_t collisionPaddle(ball_t ball, ball_t paddle){

    if(ball.position.y < 11)
    {
        if(ball.position.x > paddle.position.x && ball.position.x < (paddle.position.x + paddle.radius))
        {
            ball.velocity.y = 0 - ball.velocity.y;
            ball = updateBall(ball);
        }
    }
    return ball;
}

/*ball_t drawPaddle(ball_t paddle)
{
    drawBall(paddle.position.x, paddle.position.y, 0x0000, 9);
    int i;
    for(i = 0; i < paddle.radius; i += 10)
    {
        drawBall((paddle.position.x + i), paddle.position.y, 0xFFFF, 9);
    }
}*/

char endGame(ball_t ball)
{
    if(ball.position.y < 0)
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
