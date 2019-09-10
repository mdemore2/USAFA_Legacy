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

main:
		cmp.w #0x1234, &0x0216 		;test if greater or less than 0x1234
		jl	lessgreat
		jeq	lessgreat
		mov #20, R6					;store val to decrement
		mov.w #0x0000, &0x0206		;clear destination
		jmp	loop

loop:
		mov.w #0x0000, R7
		add R6, &0x0206				;add val
		dec R6						;decrement
		cmp R6, R7					;test if loop complete
		jeq forever
		jmp loop

less:
		bit #1, &0x0216				;test bit 0 (even or odd)
		jnz odd
		rrc &0x0216					;divide by 2
		mov.w &0x0216, &0x0212		;store val
		jmp forever

odd:
		rla &0x0216					;multiply by 2
		mov.w &0x0216, &0x0212		;store val
		jmp forever

lessgreat:
		cmp.w #0x1000, &0x0216		;test if less than 0x1000
		jl less
		jeq less
		add.w #0xEEC0, &0x0216		;add 0xEEC0
		mov.w #0x0000, &0x0202		;clear 0x0202
		adc.b &0x0202				;store carry in 0x0202
		jmp forever

forever:
		jmp forever

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
            
