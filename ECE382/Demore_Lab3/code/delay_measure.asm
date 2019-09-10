;-------------------------------------------------------------------------------
; Lesson 14 - Polling. Debouncing. Software Delay Routines.
;
; Purpose:  Program instantiates a software delay subroutine to delay LED Blinking
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file

;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
			bis.b #BIT0, &P1DIR

blinkLED:	bic.b #BIT0, &P1OUT
			call #Delay160ms
			bis.b #BIT0, &P1OUT
			call #Delay160ms
			jmp blinkLED


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
		nop
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
