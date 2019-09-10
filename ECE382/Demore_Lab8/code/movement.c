/*
 * movement.c
 *
 *  Created on: Nov 15, 2017
 *      Author: C19Mark.Demore
 */
#include <msp430.h>
#include "movement.h"

/*
void main(void)
{

       init();

       moveForward();
       __delay_cycles(DELAY_CYCLES);
       __delay_cycles(DELAY_CYCLES);
       __delay_cycles(DELAY_CYCLES);
       stop();
       __delay_cycles(DELAY_CYCLES);

       moveBackward();
       __delay_cycles(DELAY_CYCLES);
       __delay_cycles(DELAY_CYCLES);
       __delay_cycles(DELAY_CYCLES);
       stop();
       __delay_cycles(DELAY_CYCLES);

       bigRight();
       stop();
       __delay_cycles(DELAY_CYCLES);

       bigLeft();
       stop();
       __delay_cycles(DELAY_CYCLES);

       smallRight();
       stop();
       __delay_cycles(DELAY_CYCLES);

       smallLeft();
       stop();
       __delay_cycles(DELAY_CYCLES);


}
*/

void init (void)
{
            WDTCTL = WDTPW|WDTHOLD;                 // stop the watchdog timer

            BCSCTL1 = CALBC1_1MHZ;
            DCOCTL = CALDCO_1MHZ;


            TA1CTL |= TASSEL_2|MC_1|ID_0;           // configure for SMCLK

            TA1CCR0 = 1000;                // set signal period to 1000 clock cycles (~1 millisecond)
            TA1CCR1 = 500;                // set duty cycle to 2400/1000 (75% for set/reset)
            TA1CCR2 = 500;                  //apply to both motors, should just move forward
            TA1CCTL1 |= OUTMOD_3;        // set TACCTL1 to Set / Reset mode
            TA1CCTL2 |= OUTMOD_3;

            P2DIR |= (BIT1| BIT2 | BIT4 | BIT5);
            P2OUT &= ~(BIT1 | BIT2 | BIT4 | BIT5);
            P2SEL2 &= ~(BIT1 | BIT2 | BIT4 | BIT5);

}

void moveForward(void)
{

    //GPIO on P2.2
    P2OUT &= ~BIT2;
    P2SEL &= ~BIT2;

    //GPIO on P2.5
    P2OUT &= ~BIT5;
    P2SEL &= ~BIT5;

    TA1CCR1 = 405;                // was 400
    TA1CCR2 = 400;

    //TA1CCR1 on P2.1
    P2SEL |= BIT1;

    //TA1CCR2 on P2.4
    P2SEL |= BIT4;
}


void moveBackward(void)
{
    //GPIO on P2.1
    P2OUT &= ~BIT1;
    P2SEL &= ~BIT1;

   //GPIO on P2.4
    P2OUT &= ~BIT4;
    P2SEL &= ~BIT4;

    TA1CCR1 = 400;
    TA1CCR2 = 400;

    //TA1CCR1 on P2.2
     P2SEL |= BIT2;

     //TA1CCR2 on P2.5
     P2SEL |= BIT5;
}


void bigRight(void)
{

        //GPIO on P2.5
        P2OUT &= ~BIT5;
        P2SEL &= ~BIT5;

        //GPIO on P2.1
        P2OUT &= ~BIT1;
        P2SEL &= ~BIT1;

        TA1CCR1 = 400;
        TA1CCR2 = 400;

        //TA1CCR2 on P2.4
        P2SEL |= BIT4;

        //TA1CCR1 on P2.2
        P2SEL |= BIT2;

        __delay_cycles(.79*DELAY_CYCLES);        //was .77
        //__delay_cycles(DELAY_CYCLES/4);

}

void bigLeft(void)
{
    //GPIO on P2.2
            P2OUT &= ~BIT2;
            P2SEL &= ~BIT2;



            //GPIO on P2.4
            P2OUT &= ~BIT4;
            P2SEL &= ~BIT4;

            TA1CCR1 = 400;
            TA1CCR2 = 400;

            //TA1CCR1 on P2.1
            P2SEL |= BIT1;

            //TA1CCR2 on P2.5
            P2SEL |= BIT5;

            __delay_cycles(.67*DELAY_CYCLES);   //was .65
            //__delay_cycles(DELAY_CYCLES/4);

}

void smallRight(void)
{
    //GPIO on P2.5
            P2OUT &= ~BIT5;
            P2SEL &= ~BIT5;

            //GPIO on P2.1
            P2OUT &= ~BIT1;
            P2SEL &= ~BIT1;

            TA1CCR1 = 400;
            TA1CCR2 = 400;

            //TA1CCR2 on P2.4
            P2SEL |= BIT4;

            //TA1CCR1 on P2.2
            P2SEL |= BIT2;

            __delay_cycles(.35*DELAY_CYCLES);
            //__delay_cycles(DELAY_CYCLES/4);

}

void smallLeft(void)
{
    //GPIO on P2.2
                P2OUT &= ~BIT2;
                P2SEL &= ~BIT2;



                //GPIO on P2.4
                P2OUT &= ~BIT4;
                P2SEL &= ~BIT4;

                TA1CCR1 = 400;
                TA1CCR2 = 400;

                //TA1CCR1 on P2.1
                P2SEL |= BIT1;

                //TA1CCR2 on P2.5
                P2SEL |= BIT5;

                __delay_cycles(.375*DELAY_CYCLES);
                //__delay_cycles(DELAY_CYCLES/4);
}

void stop(void)
{
    //GPIO on P2.2
    P2OUT &= ~BIT2;
    P2SEL &= ~BIT2;

    //GPIO on P2.5
    P2OUT &= ~BIT5;
    P2SEL &= ~BIT5;

    //GPIO on P2.4
    P2OUT &= ~BIT4;
    P2SEL &= ~BIT4;

    //GPIO on P2.1
    P2OUT &= ~BIT1;
    P2SEL &= ~BIT1;
}
