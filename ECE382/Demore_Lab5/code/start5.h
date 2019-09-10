//-----------------------------------------------------------------
// Name:    Coulston
// File:    lab5.h
// Date:    Fall 2014
// Purp:    Include file for the MSP430
//-----------------------------------------------------------------

//-----------------------------------------------------------------
// Page 76 : MSP430 Optimizing C/C++ Compiler v 4.3 User's Guide
//-----------------------------------------------------------------
typedef     unsigned char       int8;
typedef     unsigned short      int16;
typedef     unsigned long       int32;
typedef     unsigned long long  int64;

#define     TRUE                1
#define     FALSE               0

//-----------------------------------------------------------------
// Function prototypes found in lab5.c
//-----------------------------------------------------------------
void initMSP430();
__interrupt void pinChange (void);
__interrupt void timerOverflow (void);


//-----------------------------------------------------------------
// Each PxIES bit selects the interrupt edge for the corresponding I/O pin.
//  Bit = 0: The PxIFGx flag is set with a low-to-high transition
//  Bit = 1: The PxIFGx flag is set with a high-to-low transition
//-----------------------------------------------------------------

#define     IR_PIN          (P2IN & BIT6)
#define     HIGH_2_LOW      P2IES |= BIT6
#define     LOW_2_HIGH      P2IES &= ~BIT6


#define     averageLogic0Pulse  616
#define     averageLogic1Pulse  504
#define     averageStartPulse   4424
#define     minLogic0Pulse      averageLogic0Pulse - 18
#define     maxLogic0Pulse      averageLogic0Pulse + 18
#define     minLogic1Pulse      averageLogic1Pulse - 19
#define     maxLogic1Pulse      averageLogic1Pulse + 19
#define     minStartPulse       averageStartPulse - 88
#define     maxStartPulse       averageStartPulse + 88

#define     MENU    0x61A028D7
#define     ENTER   0x61A018E7

#define     ONE     0x61A000FF
#define     TWO     0x61A0807F
#define     THREE   0x61A040BF
#define     NINE    0x61A010EF


#define     VOL_UP  0x61A030CF
#define     VOL_DW  0x61A0B04F
#define     CH_UP   0x61A050AF
#define     CH_DW   0x61A0D02F
