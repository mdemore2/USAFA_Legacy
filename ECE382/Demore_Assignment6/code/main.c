/**********************************************************************

 COPYRIGHT 2016 United States Air Force Academy All rights reserved.

 United States Air Force Academy     __  _______ ___    _________
 Dept of Electrical &               / / / / ___//   |  / ____/   |
 Computer Engineering              / / / /\__ \/ /| | / /_  / /| |
 2354 Fairchild Drive Ste 2F6     / /_/ /___/ / ___ |/ __/ / ___ |
 USAF Academy, CO 80840           \____//____/_/  |_/_/   /_/  |_|

 ----------------------------------------------------------------------

   FILENAME      : main.c
   AUTHOR(S)     : C2C Mark Demore II
   DATE          : 10/5/2017
   COURSE        : ECE 382

   Lesson/Hw/...e.g., Assignment 6

   DESCRIPTION   : This program tests for thresholds and stores various values based on the result.

   DOCUMENTATION : None

 Academic Integrity Statement: I certify that, while others may have
 assisted me in brain storming, debugging and validating this program,
 the program itself is my own work. I understand that submitting code
 which is the work of other individuals is a violation of the honor
 code.  I also understand that if I knowingly give my original work to
 another individual is also a violation of the honor code.

 **********************************************************************/

#include <msp430.h> 
#include <stdint.h>  // provides std data types (e.g., uint8_t)
#include <stdbool.h> // provides bool type for true and false


  /************************************************************************************/
 /* FUNCTION DECLARATIONS                                                            */
/************************************************************************************/

/**************************************************
   Function: name()
   Author: Your Name
   Description:
   Inputs:
   Returns: none
***************************************************/



  /************************************************************************************/
 /* MAIN                                                                             */
/************************************************************************************/
void main(void) {
    WDTCTL = WDTPW | WDTHOLD;   // Stop watchdog timer

    volatile unsigned char val1 = 0x40;
    volatile unsigned char val2 = 0x35;
    volatile unsigned char val3 = 0x42;

    volatile unsigned char result1 = 0;
    volatile unsigned char result2 = 0;
    volatile unsigned char result3 = 0;

    const unsigned char threshold = 0x38;
    int fib1 = 1;
    int fib2 = 1;

    if (val1 > threshold)
    {
        int i;
        for(i = 0; i < 10; i++)
        {
            result1 = fib1 + fib2;
            fib1 = fib2;                //increment through fibonacci sequence
            fib2 = result1;
        }
    }

    if(val2 > threshold)
    {
        result2 = 0xAF;
    }

    if(val3 > threshold)
    {
        result3 = val2 - 0x10;
    }

    while(true);    // CPU trap
}
