#include <msp430.h>
#include <pong.h>
//#include <pong.c>

/**
 * main.c
 */
int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer

	ball_t ball = createBall(100,100,-10,0,10);

	int i;
	for(i = 0; i < 1000; i++)
	{
	   ball = updateBall(ball);
	}

	return 0;
}

