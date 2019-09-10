/*
 * remote.c
 *
 *  Created on: Nov 24, 2017
 *      Author: C19Mark.Demore
 */
// 8MHz clock for IR sensor, used 1MHz for movement - look into using different clocks or adapt accordingly
#include <msp430.h>
#include <msp430g2553.h>
#include <stdint.h>
#include <stdbool.h>
#include "movement.h"
#include "remote.h"

int8    newIrPacket = FALSE;
int16   packetData[48];
int8    packetIndex = 0;
int32   codeRecieved;



void main(void)
{
    int mode = BIG;
       init();
       initIR();
       stop();

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
                   //P1OUT ^= BIT6;
                   moveForward();
               }
               if (codeRecieved == CH_DW)
               {
                   //P1OUT ^= BIT0;
                   moveBackward();
               }
               if(codeRecieved == VOL_DW)
               {
                   if(mode == BIG)
                   {
                       bigLeft();
                   }
                   else
                   {
                       smallLeft();
                   }
               }
               if(codeRecieved == VOL_UP)
               {
                   if(mode == BIG)
                   {
                       bigRight();
                   }
                   else
                   {
                       smallRight();
                   }
               }
               if(codeRecieved == MENU)
               {
                   if(mode == SMALL)
                   {
                       mode = BIG;
                   }
                   else
                   {
                       mode = SMALL;
                   }
               }
               __delay_cycles(DELAY_CYCLES);
               __delay_cycles(DELAY_CYCLES);
               __delay_cycles(DELAY_CYCLES);
               stop();
           }// end if new IR packet arrived
       } // end infinite loop
}




void initIR() {

    //WDTCTL=WDTPW+WDTHOLD;       // stop WD

    P2DIR &= ~BIT6;                     // Set up P2.6 as GPIO not XIN
    P2SEL &= ~BIT6;
    P2SEL2 &= ~BIT6;

    P2IFG &= ~BIT6;                     // Clear any interrupt flag on P2.6
    P2IE  |= BIT6;                      // Enable P2.6 interrupt

    HIGH_2_LOW;                         // check the header out.  P2IES changed.

    TA0CCR0 = 0xFFFF;                           // create a 16ms roll-over period
    TA0CTL &= ~TAIFG;                           // clear flag before enabling interrupts = good practice
    TA0CTL = ID_2 | TASSEL_2 | MC_1 | TAIE;     // Use 1:8 prescalar off MCLK and enable interrupts

    __enable_interrupt();
}


#pragma vector = PORT2_VECTOR           // This is from the MSP430G2553.h file

__interrupt void pinChange (void) {

    int8    pin;
    int16   pulseDuration;          // The timer is 16-bits
    if (IR_PIN)     pin=1;  else pin=0;

    switch (pin) {                  // read the current pin level
        case 0:                     // !!!!!!!!!NEGATIVE EDGE!!!!!!!!!!
            pulseDuration = TA0R*8;   //**Note** If you don't specify TA1 or TA0 then TAR defaults to TA0R        //adjusted this one here to *8 to account for 1Mhz clock
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
