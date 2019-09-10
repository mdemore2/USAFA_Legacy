/*
 * ultraSensor.h
 *
 *  Created on: Nov 30, 2017
 *      Author: C19Mark.Demore
 */

#ifndef ULTRASENSOR_H_
#define ULTRASENSOR_H_


void initSensor(void);
int checkWall(void);

#define present 1
#define absent 0

#define leftWall    3
#define rightWall   2
#define centerWall  1
#define noWall  0

#define TRUE 1
#define FALSE 0

typedef     unsigned char       int8;
typedef     unsigned short      int16;
typedef     unsigned long       int32;
typedef     unsigned long long  int64;

#define     TRUE                1
#define     FALSE               0
#define     HIGH_2_LOW      P1IES |= BIT3
#define     LOW_2_HIGH      P1IES &= ~BIT3


#endif /* ULTRASENSOR_H_ */
