;-------------------------------------------------------------
;Lab 2 - Cryptography
;C2C Mark Demore, USAF / 11 Sep 2017 / 14 Sep 2017
;
; This program decrypts messages given a key of variable length.
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

message: 	.byte 0xef,0xc3,0xc2,0xcb,0xde,0xcd,0xd8,0xd9,0xc0,0xcd,0xd8,0xc5,0xc3,0xc2,0xdf,0x8d,0x8c,0x8c,0xf5,0xc3,0xd9,0x8c,0xc8,0xc9,0xcf,0xde,0xd5,0xdc,0xd8,0xc9,0xc8,0x8c,0xd8,0xc4,0xc9,0x8c,0xe9,0xef,0xe9,0x9f,0x94,0x9e,0x8c,0xc4,0xc5,0xc8,0xc8,0xc9,0xc2,0x8c,0xc1,0xc9,0xdf,0xdf,0xcd,0xcb,0xc9,0x8c,0xcd,0xc2,0xc8,0x8c,0xcd,0xcf,0xc4,0xc5,0xc9,0xda,0xc9,0xc8,0x8c,0xde,0xc9,0xdd,0xd9,0xc5,0xde,0xc9,0xc8,0x8c,0xca,0xd9,0xc2,0xcf,0xd8,0xc5,0xc3,0xc2,0xcd,0xc0,0xc5,0xd8,0xd5,0x8f
;message:	.byte 0xf8,0xb7,0x46,0x8c,0xb2,0x46,0xdf,0xac,0x42,0xcb,0xba,0x03,0xc7,0xba,0x5a,0x8c,0xb3,0x46,0xc2,0xb8,0x57,0xc4,0xff,0x4a,0xdf,0xff,0x12,0x9a,0xff,0x41,0xc5,0xab,0x50,0x82,0xff,0x03,0xe5,0xab,0x03,0xc3,0xb1,0x4f,0xd5,0xff,0x40,0xc3,0xb1,0x57,0xcd,0xb6,0x4d,0xdf,0xff,0x4f,0xc9,0xab,0x57,0xc9,0xad,0x50,0x80,0xff,0x53,0xc9,0xad,0x4a,0xc3,0xbb,0x50,0x80,0xff,0x42,0xc2,0xbb,0x03,0xdf,0xaf,0x42,0xcf,0xba,0x50
end_byte:	.byte 0x55
key:		.byte 0xac
;key:		.byte 0xac,0xdf,0x23
key_end:	.byte 0x55

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
	mov #key_end, r13		;key length
	mov #end_byte, r14		;message length
	mov #0x200, r15			;output location
	mov #message, r10		;message location  --- figure out how to get from .byte
	mov #key, r9			;key location	--- figure out how to get from .byte
	sub r10, r14			;message counter
	sub r9, r13				;key counter
	mov r13, r8				;key counter reset

	jmp decryptMessage

decryptByte:
	xor.b r11, r12
	ret

decryptMessage:
	cmp #0, r10			; ---adjust to test end ;cmp @r10, r14
	jeq cpu_trap			;<- or ret at end and do cmp jnz statements in main
	cmp #0, r13			; ---adjust to test end
	jeq reset_key_loc

	mov.b @r10, r11
	mov.b @r9, r12
	call #decryptByte
	mov.b r12, 0(r15)
	dec r14
	dec r13
	inc r10
	inc r9
	inc r15
	jmp decryptMessage

cpu_trap:
	jmp cpu_trap

reset_key_loc:
	clr r13
	add r8, r13
	mov #key, r9
	jmp decryptMessage


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
            
