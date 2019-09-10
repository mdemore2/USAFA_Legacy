/*
 * remote.h
 *
 *  Created on: Nov 24, 2017
 *      Author: C19Mark.Demore
 */

#ifndef REMOTE_H_
#define REMOTE_H_


#define BIG 1
#define SMALL 0
#define TRUE 1
#define FALSE 0


typedef     unsigned char       int8;
typedef     unsigned short      int16;
typedef     unsigned long       int32;
typedef     unsigned long long  int64;

void initIR(void);

void initMSP430();
__interrupt void pinChange (void);
__interrupt void timerOverflow (void);

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



#endif /* REMOTE_H_ */
