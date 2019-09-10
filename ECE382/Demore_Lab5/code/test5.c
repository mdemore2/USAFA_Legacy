//-----------------------------------------------------------------
// Name:    Coulston
// File:    test5.c
// Date:    Fall 2014, updated by Trimble Fall 15
// Purp:    Measure IR pulses
//-----------------------------------------------------------------
#include <msp430.h>

typedef     unsigned char       int8;
typedef     unsigned short      int16;

#define SAMPLE_SIZE         48
#define IR_DECODER_PIN      (P2IN & BIT6)
void initMSP430();

// -----------------------------------------------------------------------
// -----------------------------------------------------------------------
void main(void) {

    int16 time1[SAMPLE_SIZE], time0[SAMPLE_SIZE];
    int8  i;


    initMSP430();               // Set up MSP to process IR and buttons

    while (1)  {

        while(IR_DECODER_PIN != 0);         // IR input is nominally logic 1

        for(i=0; i<SAMPLE_SIZE; i++) {
            //**Note** If you don't specify TA1 or TA0 then TAR defaults to TA0R
            TAR = 0;                        // reset timer and
            while(IR_DECODER_PIN==0);       // wait while IR is logic 0
            time0[i] = TAR;                 // and store timer A

            TAR = 0;                        // reset timer and
            while(IR_DECODER_PIN != 0);     // wait while IR is logic 1
            time1[i] = TAR;                 // and store timer A

        } // end for
    } // end while
} // end main


// -----------------------------------------------------------------------
// -----------------------------------------------------------------------
void initMSP430() {

    IFG1=0;                     // clear interrupt flag1
    WDTCTL=WDTPW+WDTHOLD;       // stop WD

    BCSCTL1 = CALBC1_8MHZ;
    DCOCTL = CALDCO_8MHZ;
                                        // Fill in the next six lines of code.
    TAR = 0;                                    // ensure TAR is clear
    TA0CCR0 = 65000;                                    // create a ~65 ms roll-over period with TA0CCR0
    TA0CTL |= ID_3 | TASSEL_2 | MC_1 ;         // Use 1:8 prescalar off SMCLK

    P2DIR &= ~BIT6;                                    // Set up P2.6 as GPIO not XIN
    P2SEL &= ~BIT6;                                    // This action takes
    P2SEL2 &= ~BIT6;                                     // three lines of code.


} // end initMSP430
