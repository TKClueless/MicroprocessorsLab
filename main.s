	#include <xc.inc>
extrn	delay_ms, delay_x4us
extrn	pop_table
extrn	read_col
	
psect	udata_acs
	col_num:	ds 1
	row_num:	ds 1
	row_col:	ds 1
	bit_cnt:	ds 1
	
psect	code, abs
	
main:
	org	0x0
	goto	setup	    ; Main code starts here at address 0x100
setup:	;enables pull up resistors for port E
	clrf	TRISH, A
	clrf	TRISF, A
	movlw 	0x0F
	movwf	BSR, A
	bsf	PADCFG1, 6, B
	clrf	BSR
	clrf	LATE, A
	call 	read_col
;	call	decode
	bra	combine
;read_col:
;	movwf	TRISE, A  ;enables pins 0-3 as inputs
;	movlw	10
;	call	delay_x4us
;	movlw	0x0F
;	movff	PORTE, col_num, A
;	movff	PORTE, PORTH
;	bra	read_row
;
;read_row:
;	movlw 0xf0
;	movwf TRISE, A
;	movlw 10
;	call  delay_x4us
;	movff PORTE, row_num, A
;	movff PORTE, PORTH
;	movlw 10
;	call  delay_ms
;	bra combine
	
combine:			;combines the readings of the column and row  
	movf row_num, W, A
	addwf col_num, W, A
	movwf row_col, A
	movlw 0xFF
	XORWF row_col, F, A    ;XOR W with row_col, putting result back in row_col
	movff row_col, PORTF, A
	movlw 10
	call delay_ms
	call test
	
test:
	movlw 0x30
	movf high(row_col), W, A ;separate row_col into nibbles
	call pop_table	    ;compare nibble using pop_table
	addwf bit_cnt, F, A	    ;update pop counter
	movf low(row_col), W, A
	call pop_table
	addwf bit_cnt, F, A
	movlw 2
	cpfsgt bit_cnt, A	    ;if pop count >2 return error
	;error "Multiple buttons depressed"
	
decode:
	movf row_col, W, A
	;call ascii_table
	 
	goto 0x00
	
	
	
	
	
