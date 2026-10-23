	#include <xc.inc>
	
	global read_col, read_row
	extrn	delay_x4us, delay_ms
	psect button_read, class=code
	
	read_col:
	movwf	TRISE, A  ;enables pins 0-3 as inputs
	movlw	10
	call	delay_x4us
	movlw	0x0F
	movff	PORTE, col_num, A
	movff	PORTE, PORTH
	bra	read_row
	
	read_row:
	movlw 0xf0
	movwf TRISE, A
	movlw 10
	call  delay_x4us
	movff PORTE, row_num, A
	movff PORTE, PORTH
	movlw 10
	call  delay_ms
	return
	
	
	
