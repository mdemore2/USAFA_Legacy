#include <msp430.h>

#define DELAY_CYCLES 500000

void main(void)
{
    WDTCTL = WDTPW|WDTHOLD;                 // stop the watchdog timer

    BCSCTL1 = CALBC1_8MHZ;
    DCOCTL = CALDCO_8MHZ;

    P2DIR |= BIT1;                // TA1CCR1 on P2.1
    P2SEL |= BIT1;
    P2OUT &= ~BIT1;

    P1DIR |= BIT2;
    P1SEL |= BIT2;
    P1OUT &= ~BIT2;

    TA1CTL |= TASSEL_2|MC_1|ID_0;           // configure for SMCLK
    TA0CTL |= TASSEL_2|MC_1|ID_0;

    //use LED (P1.0) to indicate duty cycle has toggled and button (P1.3) to toggle
    P1DIR = BIT0|BIT6;
    P1REN = BIT3;
    P1OUT = BIT3;

    TA1CCR0 = 1000;                // set signal period to 1000 clock cycles (~1 millisecond)
    TA1CCR1 = 250;                // set duty cycle to 250/1000 (75% for set/reset)
    TA1CCTL1 |= OUTMOD_3;        // set TACCTL1 to Set / Reset mode

    TA0CCR0 = 1000;
    TA0CCR1 = 250;
    TA0CCTL1 |= OUTMOD_3;


    while (1) {

        while (P1IN & BIT3);    //every time the button is pushed, toggle the duty cycle
        __delay_cycles(DELAY_CYCLES);
        TA1CTL &= ~MC_1;
        TA1CCR1 = 500;            // set duty cycle to 500/1000 (50%)
        TA1CTL |= MC_1;
        P1OUT ^= BIT0;

        TA0CTL &= ~MC_1;
        TA0CCR1 = 500;
        TA0CTL |= MC_1;

        while (P1IN & BIT3);
        __delay_cycles(DELAY_CYCLES);
        TA1CTL &= ~MC_1;
        TA1CCR1 = 750;            // set duty cycle to 750/1000 (25%)
        TA1CTL |= MC_1;
        P1OUT ^= BIT0;

        TA0CTL &= ~MC_1;
        TA0CCR1 = 750;
        TA0CTL |= MC_1;

        while (P1IN & BIT3);
        __delay_cycles(DELAY_CYCLES);
        TA1CTL &= ~MC_1;
        TA1CCR1 = 1000;            // set duty cycle to 1000/1000 (0%)
        TA1CTL |= MC_1;
        P1OUT ^= BIT0;

        TA0CTL &= ~MC_1;
        TA0CCR1 = 1000;
        TA0CTL |= MC_1;

        while (P1IN & BIT3);
        __delay_cycles(DELAY_CYCLES);
        TA1CTL &= ~MC_1;
        TA1CCR1 = 0;            // set duty cycle to 0/1000 (100%)
        TA1CTL |= MC_1;
        P1OUT ^= BIT0;

        while (P1IN & BIT3);
        __delay_cycles(DELAY_CYCLES);
        TA1CTL &= ~MC_1;
        TA1CCR1 = 100;            // set duty cycle to 100/1000 (90%)
        TA1CTL |= MC_1;
        P1OUT ^= BIT0;

        TA0CTL &= ~MC_1;
        TA0CCR1 = 100;
        TA0CTL |= MC_1;

        while (P1IN & BIT3);
        __delay_cycles(DELAY_CYCLES);
        TA1CTL &= ~MC_1;
        TA1CCR1 = 250;            // set duty cycle to 250/1000 (75% for set/reset)
        TA1CTL |= MC_1;
        P1OUT ^= BIT0;

        TA0CTL &= ~MC_1;
        TA0CCR1 = 250;
        TA0CTL |= MC_1;
    }
}
