/*******************************************
  * Author: C2C Mark Demore II
  * Created: 03 Nov 2017
  * Description: This program runs an etch-a-sketch game playable using a remote.
  * Documentation: None
*******************************************/


#include <msp430g2553.h>
#include <stdint.h>
#include <stdbool.h>
#include "colors.h"
#include "pong.h"
#include "fonts.h"
#include "start5.h"

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

int8    newIrPacket = FALSE;
int16   packetData[48];
int8    packetIndex = 0;
int32   codeRecieved;


void main()
   {

    uint16_t x, y, fgColor;
        //bool buttonPress = false;

        // === Initialize system ================================================
        IFG1 = 0; /* clear interrupt flag1 */
        WDTCTL = WDTPW+WDTHOLD; /* stop WD */

        initMSP();
        initMSP430();
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
        while(1)
        {


            if (packetIndex > 33)
            {

                    //P1OUT &= ~(BIT6 | BIT0);
                    codeRecieved = 0;
                    packetIndex = 0;
                    int i = 2;
                    for(i = 0; i < 34; i++)
                    {
                                if(packetData[i] > 2750)    //decode
                                {
                                    codeRecieved = (codeRecieved << 1) | 1;
                                }
                                else if(packetData[i] > 950)
                                {
                                    codeRecieved = (codeRecieved << 1) | 0;
                                }
                    }
                            if (codeRecieved == CH_UP)
                            {
                                ball.velocity.y = -5;
                                ball.velocity.x = 0;
                                ball = updateEtch(ball);
                                drawBox(ball.position.x,ball.position.y,fgColor, ball.radius);

                            }
                            if (codeRecieved == CH_DW)
                            {
                                ball.velocity.y = 5;
                                ball.velocity.x = 0;
                                ball = updateEtch(ball);
                                drawBox(ball.position.x,ball.position.y,fgColor, ball.radius);

                            }
                            if(codeRecieved == VOL_DW)
                            {
                                ball.velocity.y = 0;
                                ball.velocity.x = -5;
                                ball = updateEtch(ball);
                                drawBox(ball.position.x,ball.position.y,fgColor, ball.radius);

                            }
                            if(codeRecieved == VOL_UP)
                            {
                                ball.velocity.y = 0;
                                ball.velocity.x = 5;
                                ball = updateEtch(ball);
                                drawBox(ball.position.x,ball.position.y,fgColor, ball.radius);

                            }

                            if(codeRecieved == MENU)
                            {
                                if(fgColor == COLOR_16_YELLOW)
                                {
                                      fgColor = COLOR_16_CYAN;
                                }
                                else
                                {
                                     fgColor = COLOR_16_YELLOW;
                                }

                            }
                       }// end if new IR packet arrived

                } // end infinite loop
   }



void initMSP430() {

    WDTCTL=WDTPW+WDTHOLD;       // stop WD

    BCSCTL1 = CALBC1_8MHZ;
    DCOCTL = CALDCO_8MHZ;

    P2DIR &= ~BIT6;                     // Set up P2.6 as GPIO not XIN
    P2SEL &= ~BIT6;
    P2SEL2 &= ~BIT6;


    P2IFG &= ~BIT6;                     // Clear any interrupt flag on P2.6
    P2IE  |= BIT6;                      // Enable P2.6 interrupt

    HIGH_2_LOW;                         // check the header out.  P2IES changed.

    P1DIR |= (BIT6 | BIT0);                      // Set LEDs as outputs
    //P1DIR |= BIT0;
    P1OUT &= ~(BIT6 | BIT0);                      // And turn the LEDs off

    TA0CCR0 = 0xFFFF;                           // create a 16ms roll-over period
    TA0CTL &= ~TAIFG;                           // clear flag before enabling interrupts = good practice
    TA0CTL = ID_2 | TASSEL_2 | MC_1 | TAIE;     // Use 1:8 prescalar off MCLK and enable interrupts

    _enable_interrupt();
}


#pragma vector = PORT2_VECTOR           // This is from the MSP430G2553.h file

__interrupt void pinChange (void) {

    int8    pin;
    int16   pulseDuration;          // The timer is 16-bits
    if (IR_PIN)     pin=1;  else pin=0;

    switch (pin) {                  // read the current pin level
        case 0:                     // !!!!!!!!!NEGATIVE EDGE!!!!!!!!!!
            pulseDuration = TA0R;   //**Note** If you don't specify TA1 or TA0 then TAR defaults to TA0R
            //classify logic 1 or 0 and store
            packetData[packetIndex++] = pulseDuration;
            //timer A off
            LOW_2_HIGH;                 // Set up pin interrupt on positive edge
            break;

        case 1:                         // !!!!!!!!POSITIVE EDGE!!!!!!!!!!!
            TA0R = 0x0000;                      // time measurements are based at time 0
            //timer A on
            //enable timer A interrupt
            HIGH_2_LOW;                         // Set up pin interrupt on falling edge
            break;
    } // end switch

    P2IFG &= ~BIT6;         // Clear the interrupt flag to prevent immediate ISR re-entry

} // end pinChange ISR

#pragma vector = TIMER0_A1_VECTOR           // This is from the MSP430G2553.h file
__interrupt void timerOverflow (void) {

    TA0CTL &= ~TAIFG;   //clear flag
    //turn timer A AND interrupt off?
    packetIndex = 0;
    newIrPacket = TRUE;
}

