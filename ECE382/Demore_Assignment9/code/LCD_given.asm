;*******************************************
  ; Author: C2C Mark Demore II
  ; Created: 16 Oct 2017
  ; Description: This program interfaces with the LCD boosterpack to set up the LCD and draw boxes of variable size.
  ; it also features multiple delay functions to deal with button presses.
  ; Documentation: None
;******************************************


;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
; This is copied from LCD_move_block file LCD_ori_main_read.asm
; Then it was modified.  Muahahahahaha.
; Now there is no main loop.   This is meant to be called from C.

;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file

;-------------------------------------------------------------------------------
UCBxTXBUF: 		.equ UCB0TXBUF
UCBxRXBUF:		.equ UCB0RXBUF
UCBxSTAT: 		.equ UCB0STAT
UCBxBR0:		.equ UCB0BR0
LCD_SCLK_PIN:	.equ	0x0020
LCD_CS_PIN:		.equ	0x0001
LCD_MOSI_PIN:	.equ	0x0080
LCD_MISO_PIN:	.equ	0x0040
LCD_DC_PIN:		.equ	0x0010
COMMAND:		.equ	0x0000
DATA:			.equ	0x0001
PWRCTRLA:		.equ	0xCB
PWRCTRLB:		.equ	0xCF
DTCTRLA1:		.equ	0xE8
DTCTRLB:		.equ	0xEA
POSC:			.equ	0xED
PRC:			.equ	0xF7
ILIPC1:			.equ	0xC0
ILIPC2:			.equ	0xC1
ILIVC1:			.equ	0xC5
ILIVC2:			.equ	0xC7
ILIMAC:			.equ	0x36
COLMOD:			.equ	0x3A
ILIFCNM:		.equ	0xB1
ILIDFC:			.equ	0xB6
ILIGFD:			.equ	0xF2
ILIGS:			.equ	0x26
ILIPGC:			.equ	0xE0
ILINGC:			.equ	0xE1
RAMWRP:     	.equ	0x2C
DISPON:    		.equ	0x29
SLEEPOUT:		.equ	0x11
CASETP:     	.equ	0x2A
PASETP:      	.equ	0x2B
LCD_HEIGHT:		.equ	320
LCD_WIDTH:		.equ	240
COLOR1:			.equ	0x4416	;steel blue
ORIENT:			.equ	0x88	;;this sets default screen orientation. other values are 0x48, 0xE8, 0x88, 0x28. Origin at upper L corner.

;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section
            .retainrefs                     ; Additionally retain any sections
                                            ; that have references to current
                                            ; section
			.global		initMSP
			.global		initLCD
			.global		clearScreen
			.global		drawBox
			.global		Delay160ms
			.global 	initBTNS
			.global		Delay40ms

gamma1:		.byte		0x0F, 0x31, 0x2B, 0x0C, 0x0E, 0x08, 0x4E, 0xF1
			.byte		0x37, 0x07, 0x10, 0x03, 0x0E, 0x09, 0x00	;yes, there are only 15 parameters
gamma2:		.byte		0x00, 0x0E, 0x14, 0x03, 0x11, 0x07, 0x31, 0xC1
			.byte		0x48, 0x08, 0x0F, 0x0C, 0x31, 0x36, 0x0F


;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer


;-------------------------------------------------------------------------------
;	Name: initBTNS
;	Inputs: none
;	Outputs: none
;	Purpose: setup buttons for polling
;	Registers: none
;-------------------------------------------------------------------------------
initBTNS:
		bic.b  	#BIT3, &P1DIR	;prepare S1 button for polling
        bis.b  	#BIT3, &P1REN
        bis.b  	#BIT3, &P1OUT

        bic.b  	#BIT0, &P2DIR	;prepare S2 button for polling
        bis.b  	#BIT0, &P2REN
        bis.b  	#BIT0, &P2OUT

        bic.b  	#BIT1, &P2DIR	;prepare S3 button for polling
        bis.b  	#BIT1, &P2REN
        bis.b  	#BIT1, &P2OUT

        bic.b  	#BIT2, &P2DIR	;prepare S4 button for polling
        bis.b  	#BIT2, &P2REN
        bis.b  	#BIT2, &P2OUT

        bic.b  	#BIT3, &P2DIR	;prepare S5 button for polling
        bis.b  	#BIT3, &P2REN
        bis.b  	#BIT3, &P2OUT

;-------------------------------------------------------------------------------
;	Name: initMSP
;	Inputs: none
;	Outputs: none
;	Purpose: initialize the SPI on the MSP430
;	Registers: none
;-------------------------------------------------------------------------------
initMSP:
		mov.b	#CALBC1_8MHZ, &BCSCTL1		;now we can use the 8MHz clock signal
		mov.b	#CALDCO_8MHZ, &DCOCTL

		; let's set up the movement
		;  - initialize buttons P2.0, 2.1, 2.2, 2.3 for input
		;  - resistor enabled and it is pull up ; buttons active low
	    bic.b  #BIT0, &P2DIR	;S2 = left
        bis.b  #BIT0, &P2REN
        bis.b  #BIT0, &P2OUT

       	bic.b  #BIT1, &P2DIR	;S3 = down
        bis.b  #BIT1, &P2REN
        bis.b  #BIT1, &P2OUT

        bic.b  #BIT2, &P2DIR	;S4 = up
        bis.b  #BIT2, &P2REN
        bis.b  #BIT2, &P2OUT

        bic.b  #BIT3, &P2DIR	;S5 = right
        bis.b  #BIT3, &P2REN
        bis.b  #BIT3, &P2OUT

        bic.b  	#BIT3, &P1DIR	;S1 = other random switch
        bis.b  	#BIT3, &P1REN
        bis.b  	#BIT3, &P1OUT

		bis	#LCD_SCLK_PIN, &P1OUT
		bis	#LCD_SCLK_PIN, &P1DIR
		bis #LCD_CS_PIN, &P1OUT
		bis #LCD_CS_PIN, &P1DIR
		bis #LCD_MOSI_PIN, &P1OUT
		bis #LCD_MOSI_PIN, &P1DIR
		bis	#LCD_DC_PIN, &P1OUT
		bis #LCD_DC_PIN, &P1DIR

		bis.b	#UCSWRST, &UCB0CTL1
		mov #UCCKPH|UCMSB|UCMST|UCSYNC, &UCB0CTL0
		bis #UCSSEL_2, &UCB0CTL1
		bis #BIT0, &UCB0BR0
		clr	&UCB0BR1
		bis	#LCD_SCLK_PIN|LCD_MOSI_PIN|LCD_MISO_PIN, &P1SEL
		bis	#LCD_SCLK_PIN|LCD_MOSI_PIN|LCD_MISO_PIN, &P1SEL2
		bic.b	#UCSWRST, &UCB0CTL1

		ret

;-------------------------------------------------------------------------------
;	Name: initLCD
;	Inputs: none
;	Outputs: none
;	Purpose: tell the ILI9340 to get the LCD ready
;	Registers: r5, r6, r7, r12 destroyed
;-------------------------------------------------------------------------------
initLCD:
	mov.b	#PWRCTRLA, r12
	call	#writeCommand
	mov.b	#0x39, r12
	call	#writeData
	mov.b	#0x2C, r12
	call	#writeData
	mov.b	#0x00, r12
	call	#writeData
	mov.b	#0x34, r12
	call	#writeData
	mov.b	#0x02, r12
	call	#writeData

	mov.b	#PWRCTRLB, r12
	call	#writeCommand
	mov.b	#0x00, r12
	call	#writeData
	mov.b	#0xC1, r12
	call	#writeData
	mov.b	#0x30, r12
	call	#writeData

	mov.b	#DTCTRLA1, r12
	call	#writeCommand
	mov.b	#0x85, r12
	call	#writeData
	mov.b	#0x00, r12
	call	#writeData
	mov.b	#0x78, r12
	call	#writeData

	mov.b	#DTCTRLB, r12
	call	#writeCommand
	mov.b	#0x00, r12
	call	#writeData
	mov.b	#0x00, r12
	call	#writeData

	mov.b	#POSC, r12
	call	#writeCommand
	mov.b	#0x64, r12
	call	#writeData
	mov.b	#0x03, r12
	call	#writeData
	mov.b	#0x12, r12
	call	#writeData
	mov.b	#0x81, r12
	call	#writeData

	mov.b	#PRC, r12
	call	#writeCommand
	mov.b	#0x20, r12
	call	#writeData

	mov.b	#ILIPC1, r12
	call	#writeCommand
	mov.b	#0x23, r12
	call	#writeData
	mov.b	#ILIPC2, r12
	call	#writeCommand
	mov.b	#0x10, r12
	call	#writeData
	mov.b	#ILIVC1, r12
	call	#writeCommand
	mov.b	#0x3E, r12
	call	#writeData
	mov.b	#0x28, r12
	call	#writeData
	mov.b	#ILIVC2, r12
	call	#writeCommand
	mov.b	#0x86, r12
	call	#writeData

	mov.b	#ILIMAC, r12
	call	#writeCommand
	mov.b	#ORIENT, r12
	call	#writeData

	mov.b	#COLMOD, r12
	call	#writeCommand
	mov.b	#0x55, r12
	call	#writeData

	mov.b	#ILIFCNM, r12
	call	#writeCommand
	mov.b	#0x00, r12
	call	#writeData
	mov.b	#0x18, r12
	call	#writeData

	mov.b	#ILIDFC, r12
	call	#writeCommand
	mov.b	#0x08, r12
	call	#writeData
	mov.b	#0x82, r12
	call	#writeData
	mov.b	#0x27, r12
	call	#writeData

	mov.b	#ILIGFD, r12
	call	#writeCommand
	mov.b	#0x00, r12
	call	#writeData
	mov.b	#ILIGS, r12
	call	#writeCommand
	mov.b	#0x01, r12
	call	#writeData

	mov.b	#ILIPGC, r12
	call	#writeCommand
	mov		#gamma1, r5		;r5 holds address of array
	mov		#15, r6			;r6 holds count loop

PGammaCorr:
	mov.b	@r5+, r12
	call	#writeData
	dec		r6
	jnz		PGammaCorr

	mov.b	#ILINGC, r12
	call	#writeCommand
	mov		#gamma2, r5		;r5 holds address of array
	mov		#15, r6			;r6 holds count loop

NGammaCorr:
	mov.b	@r5+, r12
	call	#writeData
	dec		r6
	jnz		NGammaCorr

	mov.b	#SLEEPOUT, r12
	call	#writeCommand
	call	#Delay160ms			;need 120ms afterSLEEPOUT command

	mov.b	#DISPON, r12
	call	#writeCommand
	mov.b	#RAMWRP, r12
	call	#writeCommand

	ret

;-------------------------------------------------------------------------------
;	Name: writeCommand
;	Inputs: command in r12
;	Outputs: none
;	Purpose: send a command to the LCD
;	Registers: r12 preserved
;-------------------------------------------------------------------------------
writeCommand:
	push	r12
	bic 	#LCD_CS_PIN, &P1OUT
	bic		#LCD_DC_PIN, &P1OUT
	mov.b	 r12, &UCB0TXBUF

pollC:
	bit		#UCBUSY, &UCB0STAT	;while UCBxSTAT & UCBUSY
	jnz		pollC

	bis		#LCD_CS_PIN, &P1OUT
	pop		r12
	ret

;-------------------------------------------------------------------------------
;	Name: writeData
;	Inputs: r12 - data to be written
;	Outputs: none
;	Purpose:  send data to the LCD
;	Registers: r12 preserved
;-------------------------------------------------------------------------------
writeData:
	push	r12
	bic 	#LCD_CS_PIN, &P1OUT
	bis		#LCD_DC_PIN, &P1OUT
	mov.b 	r12, &UCBxTXBUF

pollD:
	bit	#UCBUSY, &UCBxSTAT	;while UCBxSTAT & UCBUSY
	jnz	pollD

	bis	#LCD_CS_PIN, &P1OUT
	pop	r12
	ret

;-------------------------------------------------------------------------------
;	Name: clearScreen
;	Inputs: none
;	Outputs: none
;	Purpose:  clear LCD screen
;	Registers: r6, r7, r8, r12, r13, r14, r15 used and preserved
;-------------------------------------------------------------------------------
clearScreen:
	push	r6
	push	r7
	push	r8
	push	r12
	push	r13
	push	r14
	push	r15
	mov		#0x00, r12
	mov		#0x00, r13
	mov		#LCD_WIDTH, r14	 ;240 pixels wide
	dec		r14
	mov		#LCD_HEIGHT, r15	;320 pixels tall
	dec		r15
	call	#setArea
	mov		#0x0000, r12	;0x0000 for black or 0xFFFFF for white; other colors in between
	call	#splitColor	;returns r12 with MSB of color, r13 the LSB

	mov		#LCD_WIDTH, r7
	mov		#LCD_HEIGHT, r8
paintPix:
	call	#writeData
	mov.b	r12, r6
	mov.b 	r13, r12
	call	#writeData
	mov.b	r6, r12		;r12 returned for color MSB preservation
	dec		r7
	jnz		paintPix	;paint all columns
	mov		#LCD_WIDTH, r7
	dec		r8
	jnz		paintPix	;paint each row, too
	pop		r15
	pop		r14
	pop		r13
	pop		r12
	pop		r8
	pop		r7
	pop		r6
	ret

;-------------------------------------------------------------------------------
;	Name: setArea
;	Inputs: xStart in r12, yStart in r13, xEnd in r14, yEnd in r15
;	Outputs: none
;	Purpose:  defines the area you are about to write to for LCD
;	Registers: r10, r12, 13, 14, 15 used and preserved
;-------------------------------------------------------------------------------
setArea:
	push 	r10
	push	r12
	push	r13
	push	r14
	push	r15
	mov 	r12, r10
	mov.b	#CASETP, r12	;CASETEP - column address set.  sounds like x. but if we are sideways, it must be y.
	call	#writeCommand
	swpb	r10
	mov.b	r10, r12 ;xStartMSB
	call	#writeData
	swpb	r10
	mov.b	r10, r12 ;xStart other half
	call	#writeData
	mov		r14, r10
	swpb	r10
	mov.b	r10, r12	; xEndMSB
	call	#writeData
	swpb	r10
	mov.b	r10, r12
	call	#writeData	;xEnd other half

	mov.b	#PASETP, r12
	call	#writeCommand
	mov		r13, r10
	swpb	r10
	mov.b	r10, r12	;yStartMSB
	call	#writeData
	swpb	r10
	mov.b	r10, r12	;yStart other half
	call	#writeData

	mov		r15, r10
	swpb	r10
	mov.b	r10, r12	;yEndMSB
	call	#writeData
	swpb	r10
	mov.b	r10, r12	;yEnd other half
	call	#writeData

	mov.b	#RAMWRP, r12
	call	#writeCommand

	pop		r15
	pop		r14
	pop		r13
	pop		r12
	pop		r10
	ret

;-------------------------------------------------------------------------------
;	Name: splitColor
;	Inputs: desired  color in r12
;	Outputs: color MSB in r12, bkgd color LSB in r13
;	Purpose:  splits the color word into color bytes
;	Registers: r12, r13 modified
;-------------------------------------------------------------------------------
splitColor:
	mov.b	r12, r13
	swpb	r12
	and		#0x00FF, r12	;clear upper byte of r12
	ret


;-------------------------------------------------------------------------------
;	Name: drawBox
;	Inputs: xStart in r12, yStart in r13, box color in r14, length (for paddle) in r15
;	Outputs: none
;	Purpose: draw a 10x10 box
;	Registers:
;-------------------------------------------------------------------------------

drawBox:
	push	r6
	push	r7
	push	r8
	push	r12
	push	r13
	push	r14
	push	r15
	;mov		#0x00, r12
	;mov		#0x00, r13
	mov		r14, r6
	mov		r15, r7
	mov		r12, r14
	mov		r13, r15
	add		r7, r14	 ;10 pixels wide
	add		#10, r15	;variable pixels tall
	call	#setArea
	mov		r6, r12	;0x0000 for black or 0xFFFF for white; other colors in between
	call	#splitColor	;returns r12 with MSB of color, r13 the LSB
	mov		r7, r15
	inc		r15
	mov.b		#10, r7	;these were both #10 into r7/r8
	mov.b		#10, r8
paintPixBox:
	call	#writeData
	mov.b	r12, r6
	mov.b 	r13, r12
	call	#writeData
	mov.b	r6, r12		;r12 returned for color MSB preservation
	dec		r7
	jnz		paintPixBox	;paint all columns
	mov.b	r15, r7	; this was also #10
	dec		r8
	jnz		paintPixBox	;paint each row, too
	pop		r15
	pop		r14
	pop		r13
	pop		r12
	pop		r8
	pop		r7
	pop		r6
	ret






;-------------------------------------------------------------------------------
;	Name: Delay40ms - updated for 8MHz clock
;	Inputs: none
;	Outputs: none
;	Purpose: this is a 40ms delay.
;	Registers: r7 preserved
;-------------------------------------------------------------------------------
Delay40ms:
	push	r7
	mov		#0xD154, r7		;should be ~20ms, based on 8MHz clock - plenty of room for error
delay:
	dec		r7
	jnz		delay
	mov		#0xD154, r7		;should be ~20ms, based on 8MHz clock - plenty of room for error
delay2:
	dec		r7
	jnz		delay2
	pop		r7
	ret

;-------------------------------------------------------------------------------
;	Name: Delay160ms - updated for 8 MHz clock
;	Inputs: none
;	Outputs: none
;	Purpose: creates ~160ms delay
;	Registers: r7 preserved
;-------------------------------------------------------------------------------
Delay160ms:
		push	r7
		call	#Delay40ms
		call	#Delay40ms
		call	#Delay40ms
		call	#Delay40ms
		pop		r7
		ret
;-------------------------------------------------------------------------------
;           Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect 	.stack

;-------------------------------------------------------------------------------
;           Interrupt Vectors
;-------------------------------------------------------------------------------
   ;         .sect   ".reset"                ; MSP430 RESET Vector
    ;        .short  RESET
