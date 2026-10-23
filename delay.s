	#include <xc.inc>

	global delay_ms, delay_x4us
	
psect	udata_acs
	cnt_us:	ds 1
	cnt_ms: ds 1
	cnt_l:	ds 1
	cnt_h:	ds 1
	
		
psect	delay_code, class = CODE
	
delay_ms:		    ; delay given in ms in W
	movwf	cnt_ms, A
lcdlp2:	movlw	250	    ; 1 ms delay
	call	delay_x4us	
	decfsz	cnt_ms, A
	bra	lcdlp2
	return

delay_x4us:
    movwf	cnt_us, A
    swapf	cnt_us, F, A	; swap nibbles
    movlw	0x0f	    
    andwf	cnt_l, W, A ; move low nibble to W
    movwf	cnt_h, A	; then to LCD_cnt_h
    movlw	0xf0	    
    andwf	cnt_l, F, A ; keep high nibble in LCD_cnt_l
    call	delay
    return
	
delay:			; delay routine	4 instruction loop == 250ns	    
	movlw 	0x00		; W=0
lcdlp1:	decf 	cnt_l, F, A	; no carry when 0x00 -> 0xff
	subwfb 	cnt_h, F, A	; no carry when 0x00 -> 0xff
	bc 	lcdlp1		; carry, then loop again
	return			; carry reset so return
	
