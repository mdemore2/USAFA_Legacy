/*******************************************
  * Author: C2C Mark Demore II
  * Created: 16 Oct 2017
  * Description: This program runs a pong game using the LCD boosterpack for the MSP430,
  * after losing the game, it begins playing an etch-a-sketch game.
  * Documentation: None
*******************************************/


#include <msp430g2553.h>
#include <stdint.h>
#include <stdbool.h>
#include "colors.h"
#include "pong.h"
#include "fonts.h"

extern void initMSP();
extern void initLCD();
extern void clearScreen();
extern void drawBox(uint16_t col, uint16_t row, uint16_t color, int16_t length);
extern void Delay160ms();
extern void initBTNS();
extern void Delay40ms();

// Button press (active low) defines
#define     UP_BUTTON       !(P2IN & BIT2)
#define     DOWN_BUTTON     !(P2IN & BIT1)
#define     LEFT_BUTTON     !(P2IN & BIT0)
#define     RIGHT_BUTTON    !(P2IN & BIT3)
#define     AUX_BUTTON      !(P1IN & BIT3)

void main() {

    uint16_t x, y, fgColor;
    //bool buttonPress = false;

    // === Initialize system ================================================
    IFG1 = 0; /* clear interrupt flag1 */
    WDTCTL = WDTPW+WDTHOLD; /* stop WD */

    initMSP();
    Delay160ms();
    initLCD();
    Delay160ms();
    initBTNS();
    Delay160ms();
    clearScreen();
    Delay160ms();
    clearScreen();

    x = 4;
    y = 4;
    fgColor = COLOR_16_STEEL_BLUE;
    char end;

    ball_t ball = createBall(4,4,10,10,9);

    ball_t paddle = createBall (10, 5, 0, 0, 75);

    drawBox(ball.position.x, ball.position.y, fgColor, ball.radius);
    drawBox(paddle.position.x,paddle.position.y, fgColor, paddle.radius);

    while(true) {
        //bouncing block
        drawBox(ball.position.x,ball.position.y,COLOR_16_BLACK, ball.radius);
        Delay40ms();
        ball = updateBall(ball);
        ball = collisionPaddle(ball,paddle);
        end = endGame(ball);
        if(end == TRUE)
        {
            etch();
        }
        drawBox(ball.position.x,ball.position.y,fgColor, ball.radius);
        Delay40ms();


        if(RIGHT_BUTTON){

            /*ball.velocity.y = 0;
            ball.velocity.x = 5;
           ball = updateBall(ball);
            drawBox(ball.position.x,ball.position.y,fgColor, ball.radius);
           Delay160ms();*/
            drawBox(paddle.position.x,paddle.position.y,COLOR_16_BLACK, paddle.radius);
            //Delay40ms();
            paddle.velocity.x = 5;
            paddle.velocity.y = 0;
            paddle = updateBall(paddle);
            drawBox(paddle.position.x, paddle.position.y, fgColor, paddle.radius);
            //Delay40ms();

        }
        if(LEFT_BUTTON){

          /*ball.velocity.y = 0;
           ball.velocity.x = -5;
           ball = updateBall(ball);
           drawBox(ball.position.x,ball.position.y,fgColor, ball.radius);
           Delay160ms();*/
            drawBox(paddle.position.x, paddle.position.y, COLOR_16_BLACK, paddle.radius);
            //Delay40ms();
            paddle.velocity.y = 0;
            paddle.velocity.x = -5;
            paddle = updateBall(paddle);
            drawBox(paddle.position.x,paddle.position.y,fgColor, paddle.radius);
            //Delay40ms();

        }
        if(AUX_BUTTON){             //switch colors on button press
            if(fgColor == COLOR_16_YELLOW)
            {
                fgColor = COLOR_16_CYAN;
            }
            else
            {
                fgColor = COLOR_16_YELLOW;
            }
            Delay40ms();
        }


    }


}
void etch()
   {

    uint16_t x, y, fgColor;
        //bool buttonPress = false;

        // === Initialize system ================================================
        IFG1 = 0; /* clear interrupt flag1 */
        WDTCTL = WDTPW+WDTHOLD; /* stop WD */

        initMSP();
        Delay160ms();
        initLCD();
        Delay160ms();
        initBTNS();
        Delay160ms();
        clearScreen();
        Delay160ms();
        clearScreen();

        x = 4;
        y = 4;
        fgColor = COLOR_16_STEEL_BLUE;
        char end;

        ball_t ball = createBall(4,4,10,10,9);

        ball_t paddle = createBall (10, 5, 0, 0, 75);

        drawBox(x, y, fgColor, ball.radius);
       while(true){
       if (UP_BUTTON){
           ball.velocity.y = -5;
           ball.velocity.x = 0;
           ball = updateEtch(ball);
           drawBox(ball.position.x,ball.position.y,fgColor, ball.radius);
           Delay40ms();
       }
       if (DOWN_BUTTON){

           ball.velocity.y = 5;
           ball.velocity.x = 0;
           ball = updateEtch(ball);
           drawBox(ball.position.x,ball.position.y,fgColor, ball.radius);
           Delay40ms();
       }
       if(LEFT_BUTTON)
       {
           ball.velocity.y = 0;
           ball.velocity.x = -5;
           ball = updateEtch(ball);
           drawBox(ball.position.x,ball.position.y,fgColor, ball.radius);
           Delay40ms();
       }
       if(RIGHT_BUTTON)
       {

            ball.velocity.y = 0;
            ball.velocity.x = 5;
            ball = updateEtch(ball);
            drawBox(ball.position.x,ball.position.y,fgColor, ball.radius);
            Delay40ms();
       }

       if(AUX_BUTTON){             //switch colors on button press
               if(fgColor == COLOR_16_YELLOW)
               {
                   fgColor = COLOR_16_CYAN;
               }
               else
               {
                   fgColor = COLOR_16_YELLOW;
               }
               Delay40ms();
         }
       }
   }
