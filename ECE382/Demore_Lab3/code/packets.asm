;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;		Capt Jeffrey Falkinburg
;		Fall 2016, ECE 382
;		MSP430G2553
;		This code draws a horizontal bar on the LI9341 LCD every time S1 is pressed.
;
;		This code was created using RobG's example LCD program, then modified for our particular function.
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file

;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
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
XSTART:			.equ	5
YSTART:			.equ	5
XEND:			.equ	200
YEND:			.equ	254
XLINELEN:		.equ	5
YLINELEN:		.equ	5

;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section
            .retainrefs                     ; Additionally retain any sections
                                            ; that have references to current
                                            ; section
gamma1:		.byte		0x0F, 0x31, 0x2B, 0x0C, 0x0E, 0x08, 0x4E, 0xF1
			.byte		0x37, 0x07, 0x10, 0x03, 0x0E, 0x09, 0x00	;yes, there are only 15 parameters
gamma2:		.byte		0x00, 0x0E, 0x14, 0x03, 0x11, 0x07, 0x31, 0xC1
			.byte		0x48, 0x08, 0x0F, 0x0C, 0x31, 0x36, 0x0F

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
                                            ; Main loop here
;-------------------------------------------------------------------------------
		call 	#initMSP
		call	#Delay160ms
		call 	#initLCD
		call	#Delay160ms
		call	#clearScreen

;in this sample code, pressing S1 will draw a small blue bar on the LCD.  Further pressing (or holding down) of the button will draw more bars on the screen.

		bic.b  	#BIT3, &P1DIR	;prepare the button for polling
        bis.b  	#BIT3, &P1REN
        bis.b  	#BIT3, &P1OUT
        clr		r6
		mov		#XSTART, r12
		mov		#YSTART, r13

move_line:
		mov		r12, r14
		mov		r13, r15
		add		#XLINELEN, r14
		call	#drawLine		;note the line color is set with the constant COLOR1 within this subroutine

poll_s1:
		bit.b	#BIT3, &P1IN
		jnz		poll_s1		; button is active low
		call	#Delay160ms
		add		#0x08, r12		;allows the line to change its x position
		and		#0x7F, r12
		incd	r13			; changes y position
		cmp		#310, r13
		jlo		vertFine
		mov		#YSTART, r13
vertFine:
		jmp		move_line


;-------------------------------------------------------------------------------
;	Name: initMSP
;	Inputs: none
;	Outputs: none
;	Purpose: initialize the SPI on the MSP430
;	Registers: none
;-------------------------------------------------------------------------------
initMSP:
		mov.b	#CALBC1_8MHZ, &BCSCTL1				; Setup 8MHz clock
		mov.b	#CALDCO_8MHZ, &DCOCTL
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
;	Purpose: send data to the LCD
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
;	Purpose: defines the area you are about to write to for LCD
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
;	Purpose: splits the color word into color bytes
;	Registers: r12, r13 modified
;-------------------------------------------------------------------------------
splitColor:
	mov.b	r12, r13
	swpb	r12
	and		#0x00FF, r12	;clear upper byte of r12
	ret


;-------------------------------------------------------------------------------
;	Name: drawLine
;	Inputs: xStart in r12, yStart in r13, xEnd in r14, yEnd in r15
;	Outputs: none
;	Purpose: draw a line on the LCD
;	Registers: all registers preserved
;-------------------------------------------------------------------------------
drawLine:
	push	r4
	push	r5
	push	r6
	push	r7
	push	r8
	push	r9
	push	r10
	push	r11
	push	r12
	push	r13
	push	r14
	push	r15

	cmp		r13, r15	;yEnd - yStart
	jhs		yEndBig
	mov		r15, r5		;yEnd is smaller-- r5=y0
	mov		r13, r6		;y1=r6
	jmp		lookX
yEndBig:
	mov		r13, r5		;yEnd is bigger
	mov		r15, r6		;we want the biggest ycoord in r6 (y1) and the smallest in r5 (y0)
lookX:
	cmp		r12, r14	;xEnd-xStart
	jhs		xEndBig
	mov		r14, r7		;x0=r7
	mov		r12, r8		;x1=r8
	jmp		lineTest
xEndBig:
	mov		r12, r7		;nope, xEnd is bigger than xStart
	mov		r14, r8	;again, we want the biggest xcoord in r8 (x1) and the smallest in r7 (x0)
lineTest:
	cmp		r5, r6
	jeq		horizontal
	cmp		r7, r8
	jeq		vertical
	jmp		drawEnd			; we aren't worrying with other-oriented lines right now.

horizontal:
	mov		r8, r9
	sub		r7, r9		;d
	inc		r9

draw90:
	mov		r7, r12
	mov		r5, r13
	mov		r8, r14
	mov		r6, r15
	call	#setArea
	mov		#COLOR1, r12		;set up for using the color you pre-determined
	call	#splitColor
	mov		r12, r10	;need to remember r12, since it is the color we want to use
drawCont:
	call	#writeData
	mov		r13, r12
	call	#writeData
	dec		r9
	mov		r10, r12
	jnz		drawCont
	jmp		drawEnd

vertical:
	mov		r6, r9
	sub		r5, r9		;d
	inc		r9
	jmp		draw90

drawEnd:
	pop		r15
	pop		r14
	pop		r13
	pop		r12
	pop		r11
	pop		r10
	pop		r9
	pop		r8
	pop		r7
	pop		r6
	pop		r5
	pop		r4
	ret


;-------------------------------------------------------------------------------
;	Name: drawPixel
;	Inputs: x in r12, y in r13, where (x, y) is the coordinate of the pixel
;	Outputs: none
;	Purpose: draws a pixel in a particular spot
;	Registers: r12, 13, 14, 15 preserved
;-------------------------------------------------------------------------------
drawPixel:
	push	r12
	push	r13
	push	r14
	push	r15
	mov.b	r12, r14
	mov.b	r13, r15
	call	#setArea
	mov		#COLOR1, r12
	call	#splitColor
	call	#writeData
	mov		r13, r12
	call	#writeData
	pop		r15
	pop		r14
	pop		r13
	pop		r12
	ret


;-------------------------------------------------------------------------------
;	Name: Delay160ms
;	Inputs: none
;	Outputs: none
;	Purpose: creates ~160ms delay
;	Registers: r7 preserved
;-------------------------------------------------------------------------------

Delay160ms:
		push r12
		push r13
		mov #0x534D, r12		;2 cycles
		mov #1, r13				;2 cycles
		jmp looper				;2 cycles


looper:
		cmp #0,r12				;2 cycles
		jeq reset				;2 cycles
		nop						;1 cycle
		dec r12					;sub #1, dst -> 2cycles
		jmp looper				;2 cycles

reset:
		cmp #0, r13				;2 cycles
		jeq returnFunc			;2 cycles
		dec r13					;2 cycles
		mov #0x1000, r12		;2 cycles
		jmp looper				;2 cycles

returnFunc:
		pop r13
		pop r12
		ret						;MOV @SP+,PC -> 3cycles





;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;           Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect 	.stack

;-------------------------------------------------------------------------------
;           Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
