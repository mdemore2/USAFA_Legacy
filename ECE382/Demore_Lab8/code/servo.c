/*
 * servo.c
 *
 *  Created on: Nov 30, 2017
 *      Author: C19Mark.Demore
 */
#include <msp430.h>
#include "servo.h"


void initServo()
{


               TA0CTL |= TASSEL_2|MC_1|ID_0;           // configure for SMCLK

               TA0CCR0 = 20000;                // set signal period to 20000 clock cycles (~20 millisecond)
               TA0CCR1 = 18300;                // set pulse for 1.5ms (center)
               TA0CCTL1 |= OUTMOD_3;        // set TACCTL1 to Set / Reset mode

               P1DIR |= BIT2;
               P1OUT &= ~BIT2;
               P1SEL |= BIT2;
               P1SEL2 &= ~BIT2;
}

void right()
{
    P1OUT |= BIT2;
    P1SEL |= BIT2;
    TA0CCR1 = 19500; //1ms (left)
    __delay_cycles(5 * DELAY_CYCLES);
    P1OUT &= ~BIT2;
    P1SEL &= ~BIT2;


}

void left()
{
    P1OUT |= BIT2;
        P1SEL |= BIT2;
        TA0CCR1 = 17700; //2ms (right)
        __delay_cycles(5 * DELAY_CYCLES);
        P1OUT &= ~BIT2;
        P1SEL &= ~BIT2;
}

void center()
{
    P1OUT |= BIT2;
        P1SEL |= BIT2;
        TA0CCR1 = 18500; //1.5ms (center)
        __delay_cycles(5 * DELAY_CYCLES);
        P1OUT &= ~BIT2;
        P1SEL &= ~BIT2;
}
