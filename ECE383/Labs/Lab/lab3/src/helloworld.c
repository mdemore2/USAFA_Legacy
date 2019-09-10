/*--------------------------------------------------------------------
-- Name:	Maj Jeff Falkinburg
-- Date:	Feb 19, 2017
-- File:	lec19.c
-- Event:	Lecture 19
-- Crs:		ECE 383
--
-- Purp:	MicroBlaze Tutorial that implements a custom IP with interrupt
--			to MicroBlaze.
--
-- Documentation:	MicroBlaze Tutorial
--
-- Academic Integrity Statement: I certify that, while others may have
-- assisted me in brain storming, debugging and validating this program,
-- the program itself is my own work. I understand that submitting code
-- which is the work of other individuals is a violation of the honor
-- code.  I also understand that if I knowingly give my original work to
-- another individual is also a violation of the honor code.
-------------------------------------------------------------------------*/
/***************************** Include Files ********************************/

#include "xparameters.h"
#include "stdio.h"
#include "xstatus.h"

#include "platform.h"
#include "xil_printf.h"						// Contains xil_printf
#include <xuartlite_l.h>					// Contains XUartLite_RecvByte
#include <xil_io.h>							// Contains Xil_Out8 and its variations
#include <xil_exception.h>

/************************** Constant Definitions ****************************/

/*
 * The following constants define the slave registers used for our Counter PCORE
 */
#define countBase		0x44a00000
#define exWrAddr		countBase			// 1 LSBs of slv_reg0 read=Q, write=D
#define	exWen			countBase+4			// 1 LSBs of slv_reg1 are control
#define	exSel			countBase+8			// 1 LSBs of slv_reg2 for roll flag
#define	LBusOut			countBase+0xc		// 16 LSBs of slv_reg3 (0) roll clear flag
#define	RBusOut			countBase+0x10		// 16 LSBs of slv_reg4 (0) roll clear flag
#define	exLBus			countBase+0x14		// 16 LSBs of slv_reg5 (0) roll clear flag
#define	exRBus			countBase+0x18		// 16 LSBs of slv_reg6 (0) roll clear flag
#define	flagClear		countBase+0x1c		// 1 LSBs of slv_reg7 (0) roll clear flag
#define	ready			countBase+0x20		// 1 LSBs of slv_reg8 (0) roll clear flag
#define	flagQ			countBase+0x24		// 8 LSBs of slv_reg9 (0) roll clear flag
#define	triggerTime		countBase+0x28		// 10 LSBs of slv_reg10 (0) roll clear flag
#define	triggerVolt		countBase+0x2c		// 10 LSBs of slv_reg11 (0) roll clear flag
#define	forceTrigger	countBase+0x30		// 10 LSBs of slv_reg12 (0) roll clear flag



/*
 * The following constants define the Counter commands
 */
#define count_HOLD		0x00		// The control bits are defined in the VHDL
#define	count_COUNT		0x01		// code contained in lec18.vhdl.  They are
#define	count_LOAD		0x02		// added here to centralize the bit values in
#define count_RESET		0x03		// a single place.

#define printf xil_printf			/* A smaller footprint printf */

#define	uartRegAddr			0x40600000		// read <= RX, write => TX

/************************** Function Prototypes ****************************/
void myISR(void);
void fillBuffer(void);
int readOut(void);
void displayBuffer(void);
int findTrigger(void);

/************************** Variable Definitions **************************/
/*
 * The following are declared globally so they are zeroed and so they are
 * easily accessible from a debugger
 */
u16 isrCount = 0;
unsigned int buffer[2048];
unsigned int trigger_volt = 0xFF;
unsigned int trigger_time = 0xFF;
unsigned int ex_sel = 1;
unsigned int ex_wraddr = 0;
unsigned int ex_wen = 1;
int buffCount = 0;


int main(void) {

    unsigned char c;
	//int red, flg;



    init_platform();

    print("Welcome to Lab 3!\n\r");

    microblaze_register_handler((XInterruptHandler) myISR, (void *) 0);
    microblaze_enable_interrupts();

    Xil_Out8(flagClear, 0x01);					// Clear the flag and then you MUST
    Xil_Out8(flagClear, 0x00);					// allow the flag to be reset later

    Xil_Out16(triggerTime, trigger_time);
    Xil_Out16(triggerVolt,trigger_volt);
    Xil_Out8(exSel,ex_sel);
    Xil_Out16(exWrAddr, ex_wraddr);
    Xil_Out8(exWen, ex_wen);



    while(1) {

        c=XUartLite_RecvByte(uartRegAddr);


        switch(c) {

            /*-------------------------------------------------
             * Reply with the help menu
             *-------------------------------------------------
             */
            case '?':
                printf("--------------------------\r\n");
                printf("	triggerVolt = %x\r\n",trigger_volt);
                printf("     output = %d\n", readOut());
                printf("--------------------------\r\n");
                printf("?: help menu\r\n");
                printf("o: k\r\n");
                printf("f:   flush terminal\r\n");
                break;

                /*-------------------------------------------------
                 * Basic I/O loopback
                 *-------------------------------------------------
                 */
            case 'o':
                printf("k \r\n");
                break;
            case 'q':
            	displayBuffer();
            	break;


                /*-------------------------------------------------
                 * Clear the terminal window
                 *-------------------------------------------------
                 */
            case 'f':
                for (c=0; c<40; c++) printf("\r\n");
                break;
                /*-------------------------------------------------
                * decrease trigger_volt by 10
                *-------------------------------------------------
                */
            case 'U':
                trigger_volt-= 10;
                Xil_Out16(triggerVolt, trigger_volt);

                break;
             //decrease trigger_time by 10
            case 'L':
                  trigger_time-= 10;
                  Xil_Out16(triggerTime, trigger_time);

                  break;
                  //decrease trigger_time
                 case 'l':
                       trigger_time--;
                       Xil_Out16(triggerTime, trigger_time);

                       break;
                       //increase trigger_time by 10
                      case 'R':
                            trigger_time+= 10;
                            Xil_Out16(triggerTime, trigger_time);

                            break;
                            //increase trigger_time
                           case 'r':
                                 trigger_time++;
                                 Xil_Out16(triggerTime, trigger_time);

                                 break;
                       /*-------------------------------------------------
                * decrease trigger_volt
                *-------------------------------------------------
                */
            case 'u':
                trigger_volt--;
                Xil_Out16(triggerVolt, trigger_volt);

                break;
                /*-------------------------------------------------
                 * increase trigger_volt
                 *-------------------------------------------------
                 */
            case 'd':
                trigger_volt++;
                Xil_Out16(triggerVolt, trigger_volt);

                break;
                /*-------------------------------------------------
                 * increase trigger_volt by 10
                 *-------------------------------------------------
                 */
            case 'D':
                trigger_volt+=10;
                Xil_Out16(triggerVolt, trigger_volt);

                break;

            /*-------------------------------------------------
             * toggle exSel
             *-------------------------------------------------
             */
            case 'x':
                if(ex_sel == 0)
                {
                    ex_sel = 1;
                    Xil_Out8(exSel, ex_sel);
                    fillBuffer();
                    displayBuffer();
                }
                else
                {
                    ex_sel = 0;
                    Xil_Out8(exSel, ex_sel);
                }


                break;
            //test flag register
            case 't':
            	while(Xil_In8(ready) == 0);
            	if(Xil_In8(flagQ) != 0)
            	{
            		printf("FLAG\n");
            		Xil_Out8(flagClear, 1);
            		Xil_Out8(flagClear, 0);
            		if(Xil_In8(flagQ == 0))
            		{
            			printf("CLEAR\n");
            		}
            	}
            	else
            	{
            		printf("FAIL FLAG");
            		printf("FLAG: %d\n", Xil_In8(flagQ));
            		printf("READY: %d\n", Xil_In8(ready));

            	}
            	break;
                /*-------------------------------------------------
                 * Unknown character was
                 *-------------------------------------------------
                 */
            default:
                printf("unrecognized character: %c\r\n",c);
                break;
        } // end case

    } // end while 1

    cleanup_platform();

    return 0;
} // end main


void myISR(void) {
    isrCount = isrCount + 1;
   buffer[buffCount] = readOut();
   buffCount++;
   if(buffCount > 2048)
   {
	   buffCount = 0;
   }
}

void fillBuffer(void)
{
    int previous, next = 0;
    previous = next;
    next = readOut();

    if(previous < trigger_volt && trigger_volt < next)
    {
    	for(int i = 0; i < 2048; i++)
        {
    		previous = next;
    		next = readOut();
    		if(previous == next)
    		{
    			i--;
    		}
    		buffer[i] = readOut();// + 14000;	//CENTERS IT
        }
    }

}

void displayBuffer(void)
{
	int offset = findTrigger();
    for(int i = 0; i < 1024; i ++)
    {
        Xil_Out16(exWrAddr,i);
        Xil_Out16(exLBus,buffer[offset+i] + 14000);
        Xil_Out8(exWen, 1);
        Xil_Out8(exWen,0);
        /*if(i < 10)
        {
            printf("Addr: %d\n",Xil_In16(exWrAddr));
        	printf("exLBus: %d\n",Xil_In16(exLBus));
        }*/

    }


}

int readOut(void)
{
    u16 ret = 0;
    ret = Xil_In16(LBusOut);// + 0x8000;	//sign2unsign
    //ret += 40;	//center
    return ret;
}

int findTrigger(void)
{
	int test = 0;
	int prev = 0;
	int offset = trigger_time;
	printf("TrigT / TrigV: %d / %d\n", trigger_time, trigger_volt);
	for(int i = trigger_time; i < 2048; i++)
	{
		prev = test;
		test = buffer[i] >> 8;
		if(prev == test)
		{
			test = buffer[i+1] >> 8;
		}
		if(i< 10 + trigger_time){printf("buffVal: %d\n",test);}
		if(test == trigger_volt && prev < test)
		{
			offset = i - trigger_time;	//20 offset for screen border
			printf("Trigger found!\n");
			printf("TriggVal: %d\n", test);
			return offset;
		}

	}
	printf("Trigger NOT found :(\n");
	return 0;


}
