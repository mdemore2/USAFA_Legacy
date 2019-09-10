/*
 * ultraSensor.c
 *
 *  Created on: Nov 30, 2017
 *      Author: C19Mark.Demore
 */
#include "ultraSensor.h"
#include <msp430.h>

int pulseDuration = 0xFFFF;
int overflow = FALSE;


void initSensor()
{
    TA0CTL |= TASSEL_2|MC_1|ID_0;           // configure for SMCLK
    TA0CTL &= ~TAIFG;
    TA0CCR0 = 0xFFFF;                // set signal period to 1000 clock cycles (~1 millisecond)

    P1DIR |= (BIT4|BIT6);
    P1DIR &= ~BIT3;
    P1SEL &= ~(BIT3 | BIT4 | BIT6);
    P1SEL2 &= ~(BIT3 | BIT4 | BIT6);
    P1IFG &= ~BIT3;

    P1IE |= BIT3;
    _enable_interrupt();

}

int checkWall()
{
    int wall;
    wall = absent;
    P1OUT |= BIT4;
    _delay_cycles(200);
    P1OUT &= ~BIT4;
    _delay_cycles(1000);
    if (pulseDuration < 1000)
    {
        wall = present;

    }

    return wall;
}


#pragma vector = PORT1_VECTOR           // This is from the MSP430G2553.h file

__interrupt void pinChange (void) {

    int8    pin;
    //int16   pulseDuration;          // The timer is 16-bits

    if (P1IN & BIT3)     pin=1;  else pin=0;

    switch (pin) {                  // read the current pin level
        case 0:                     // !!!!!!!!!NEGATIVE EDGE!!!!!!!!!!
            pulseDuration = TA0R;   //**Note** If you don't specify TA1 or TA0 then TAR defaults to TA0R
            //classify logic 1 or 0 and store
            //timer A off
            if(overflow == TRUE)
            {
                pulseDuration = 0xFFFF;
                overflow = FALSE;
            }

            LOW_2_HIGH;                 // Set up pin interrupt on positive edge
            break;

        case 1:                         // !!!!!!!!POSITIVE EDGE!!!!!!!!!!!
            TA0R = 0x0000;                      // time measurements are based at time 0
            //timer A on
            //enable timer A interrupt
            HIGH_2_LOW;                         // Set up pin interrupt on falling edge
            break;
    } // end switch

    P1IFG &= ~BIT3;         // Clear the interrupt flag to prevent immediate ISR re-entry

} // end pinChange ISR


#pragma vector = TIMER0_A1_VECTOR           // This is from the MSP430G2553.h file
__interrupt void timerOverflow (void) {

    TA0CTL &= ~TAIFG;   //clear flag
    //turn timer A AND interrupt off?
    overflow = TRUE;
}
