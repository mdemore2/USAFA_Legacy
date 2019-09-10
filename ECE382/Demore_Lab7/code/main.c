#include <msp430.h> 
#include "servo.h"
#include "ultraSensor.h"

/**
 * main.c
 */

int wall = absent;
int location = noWall;
int main(void)
{
    P1DIR |= (BIT6 | BIT0);
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
    initSensor();
	initServo();
	center();
	while(1)
	{
	    initServo();
	    center();

	    initSensor();
	    wall = checkWall();
	    _delay_cycles(DELAY_CYCLES);
	    if(wall == present)
	    {
	        location = centerWall;
	        P1OUT |= BIT6;  //turn on da light
	        P1OUT |= BIT0;
	    }
	    else
	    {
	        P1OUT &= ~BIT6;
	        P1OUT &= ~BIT0;
	    }

	    initServo();
	   left();

	   initSensor();
	   wall = checkWall();
	     _delay_cycles(DELAY_CYCLES);
	   if(wall == present)
	   {
	       location = leftWall;
	       P1OUT |= BIT0;
	   }
	   else
	   {
	       P1OUT &= ~BIT6;
	       P1OUT &= ~BIT0;
	   }

	   initServo();
	   right();

	   initSensor();
	   wall = checkWall();
	     _delay_cycles(DELAY_CYCLES);

	   if(wall == present)
	   {
	       location = rightWall;
	       P1OUT |= BIT6;  //turn on da light
	   }
	   else
	   {
	       P1OUT &= ~BIT6;
	       P1OUT &= ~BIT0;
	   }
	}


	return 0;
}
