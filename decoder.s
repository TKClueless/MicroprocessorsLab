#include <xc.inc>
global combine, decode_row
extrn	row_num, col_num, row_col, bit_cnt
extrn	pop_table

psect decoder, class = CODE

combine:			;combines the readings of the column and row  
	movf row_num, W, A
	addwf col_num, W, A
	movwf row_col, A
	movlw 0xFF
	XORWF row_col, F, A    ;XOR W with row_col, putting result back in row_col
	movff row_col, PORTF, A
	bra decode
	
decode_row:
	movlw 0x30
	movf high(row_col), W, A ;separate row_col into nibbles
	call pop_table	    ;compare nibble using pop_table
	addwf bit_cnt, F, A	    ;update pop counter
	movf low(row_col), W, A
	call pop_table
	addwf bit_cnt, F, A
	movlw 2
	cpfsgt bit_cnt, A	    ;if pop count >2 return error
	;ERROR "Multiple buttons depressed"
	
decode_loop:
    clrf WREG
    cpfseq row_col
    bra
    retlw '0'
    movlw 00010001B
    cpfseq row_col
    bra
    retlw '1'
