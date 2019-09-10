#include <msp430.h> 
#include "servo.h"
#include "ultraSensor.h"
#include "movement.h"
#include "remote.h"
/**
 * main.c
 */

int wall;
int first;
int location = noWall;
int main(void)
{
   /* init();
    moveForward();
    _delay_cycles(3*DELAY_CYCLES);
    stop();
    _delay_cycles(DELAY_CYCLES);
    bigRight();
    stop();
    _delay_cycles(DELAY_CYCLES);
    bigLeft();
    stop();*/
    first = TRUE;

    P1DIR |= (BIT6 | BIT0);
    WDTCTL = WDTPW | WDTHOLD;   // stop watchdog timer
    init();
    initServo();
    left();
    _delay_cycles(DELAY_CYCLES);
    center();
    _delay_cycles(DELAY_CYCLES);

    initSensor();
    _delay_cycles(DELAY_CYCLES);
    moveForward();
    while(1)
    {
        //moveForward();
        wall = checkWall();
        if(first == TRUE)
        {
            stop(); //wasn't here but he still hittin dat wall
            wall = FALSE;
            first = FALSE;

            initServo();
            center();
            initSensor();
            moveForward();

        }
        if(wall == TRUE)
        {
            stop();
            _delay_cycles(DELAY_CYCLES);
            initServo();
            left();
            initSensor();
            _delay_cycles(DELAY_CYCLES);
            wall = checkWall();
            if(wall == present)
            {
                bigRight();

                stop();
            }
            else
            {
                bigLeft();

                stop();
            }
            initServo();
            center();
            _delay_cycles(DELAY_CYCLES);

            initSensor();
            _delay_cycles(DELAY_CYCLES);

            moveForward();
            _delay_cycles(DELAY_CYCLES);
        }
    }


    return 0;
}
