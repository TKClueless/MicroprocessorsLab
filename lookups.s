	#include <xc.inc>

psect	udata_acs
	col_num:	ds 1
	row_num:	ds 1
	row_col:	ds 1
	delay_counter:	ds 1
	
psect	code, abs
	
main:
	org	0x0
	goto	setup
	org	0x100		    ; Main code starts here at address 0x100
setup:	;enables pull up resistors for port E
	clrf	TRISH, A
	clrf	TRISF, A
	movlw 	0x0f
	movwf	BSR, A
	bsf	PADCFG1, 6, B
	bra 	read_col
	
read_col:
	movwf	TRISE, A  ;enables pins 0-3 as inputs
	movlw	0xDD
	movwf	LATE, A
	movff	PORTE, col_num, A
	movff	PORTE, PORTH
	movlw	0x0f
	movwf	delay_counter, A
	call	delay
	bra	read_row

delay:
    decfsz  delay_counter, F, A
    bra delay
    return
    
read_row:
	movlw 0xf0
	movwf TRISE, A
	movwf LATE, A
	movff PORTE, row_num, A
	movff PORTE, PORTH
	movlw 0x0f
	movwf delay_counter, A
	call  delay
	bra decode
	
decode:		    ;decodes row and column data into 2 nibbles containing 1 bit each   
	movf row_num, W, A
	addwf col_num, W, A
	movwf row_col, A
	movlw 0xFF
	XORWF row_col, F, A    ;XOR W with row_col, putting result back in row_col
	movff row_col, PORTF, A
	call delay
;	movlw	0x88
;	cpfsgt	row_col, A
;	bra error_msg
	
;test:
	
	
;error_msg:
    
	
	
	goto 0x00
	
	
	
	
	
