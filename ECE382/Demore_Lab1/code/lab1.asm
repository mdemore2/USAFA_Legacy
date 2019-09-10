;-------------------------------------------------------------
;Lab 1 - Assembly Calculator
;C2C Mark Demore, USAF / 06 Sep 2017 / 11 Sep 2017
;
; This program is a calculator, that takes input from ROM and stores output in RAM.
;-------------------------------------------------------------

;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------


            .text                           ; Assemble into program memory.

test1: .byte 0x11, 0x11, 0x11, 0x11, 0x11, 0x44, 0x22, 0x22, 0x22, 0x11, 0xCC, 0x55

test2: .byte 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0xDD, 0x44, 0x08, 0x22, 0x09, 0x44, 0xFF, 0x22, 0xFD, 0x55

test3: .byte 0x22, 0x11, 0x22, 0x22, 0x33, 0x33, 0x08, 0x44, 0x08, 0x22, 0x09, 0x44, 0xff, 0x11, 0xff, 0x44, 0xcc, 0x33, 0x02, 0x33, 0x00, 0x44, 0x33, 0x33, 0x08, 0x55


ADD_OP .equ 0x11
SUB_OP .equ 0x22
MUL_OP .equ 0x33
CLR_OP .equ 0x44
END_OP .equ 0x55


            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.


result: .space 50


;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

main:
	clr R5
	clr R4
	clr R6
	clr R7
	clr R8
	clr R9
	clr R10
	clr R11

	;mov #test1, R5		;store read location
	;mov #test2, R5
	mov #test3, R5
	mov #0x0200, R4		;store write location
	jmp get_val1

get_val1:
	mov.b @R5, R6	;read location, store val
	inc R5			;decrement read location

	jmp get_operator
	;after first use result
	;once clear, use next val

get_operator:
	mov.b @R5, R7		;read location, store val
	inc R5				;decrement read location

	mov #0x55, R11
	cmp R7, R11
	jeq end

	mov #0x44, R11
	cmp R7, R11
	jeq clr

	mov #0x33, R11
	cmp R7, R11
	jeq mul

	mov #0x22, R11
	cmp R7, R11
	jeq sub

	mov #0x11, R11
	cmp R7, R11
	jeq add

	jmp end

end:
	jmp end				;cpu trap

clr:
	clr R8				;clr result
	;mov SR, R9
	jmp store_clr

mul:
	call #get_val2
	jmp mul_loop

mul_loop:

	cmp #0, R8			;check if done multiplying

	jeq mul_store

	bit #1, R8			;check bit-0
	jnz mul_add			;if one, add
	jz mul_shift		;else, shift (no need to add 0)

	;bit shift


	;and each bit of val2 with all of val1
	;OR -> check if bit is one, then add and shift

mul_add:

	add R6, R10		;add val to running total
	mov SR, R9
	jmp mul_shift


mul_shift:

	rla R6			;shift multiplicand
	rra R8			;shift multiplier
	jmp mul_loop

sub:
	call #get_val2		;get val
	sub R8, R6			;subtract
	mov SR, R9
	mov R6, R8
	jmp store_res		;store
add:
	call #get_val2		;get val
	add R6, R8			;add
	mov SR, R9
	jmp store_res		;store

get_val2:
	mov.b @R5, R8		;retrieve
	inc R5			;increment
	ret				;return to function

mul_store:
	mov R10, R8		;move result to dest to be stored
	jmp store_res


store_clr:
	mov.b R8, 0(R4)
	inc	R4
	mov.b @R5, R6
	inc R5
	jmp get_operator

store_res:
	bit #100b, R9		;check negative
	jnz store_min

	;bit #10b, R9			;check carry
	;jnz store_max
	mov #255, R12
	cmp R12, R8
	jge store_max

	mov.b R8, 0(R4)		;store result
	inc R4			;increment write location

	mov R8, R6
	clr R8
	jmp get_operator

store_max:
	mov.b #255, R8
	mov.b R8, 0(R4)		;store result
	inc R4			;increment write location
	mov R8, R6
	clr R8

	jmp get_operator

store_min:
	mov.b #0, R8
	mov.b R8, 0(R4)		;store result
	inc R4			;increment write location
	mov R8, R6
	clr R8

	jmp get_operator

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
