#include <xc.inc>
	
psect	code, abs

main:
    org 0x00
    goto SPI_MasterInit
    goto setup
    org 0x100
    
setup:	
	bcf	CFGS	; point to Flash program memory  
	bsf	EEPGD 	; access Flash program memory
	EQU DelayCounter 0x10
	movlw 0xFF
	movwf TRISH, A	; Set portH to input
	goto start
	
StartTable:
    db 0x10,0x0F,0x0E,0x0D,0x0C,0x0B,0x0A,0x08,0x07
    EQU myTable 0x400
    EQU TableCounter 0x11
    align 2
    
EndTable:
    
SPI_MasterInit: ;Setting clock edge to negative
    bcf CKE2	;CKE bit in SSP2STAT
    
    movlw (SSP2CON1_SSPEN_MASK) | (SSP2CON1_CKP_MASK) | (SSPCON1_SSPM1_MASK)
    movwf 	SSP2CON1, A?
    ; SDO2 output; SCK2 output?
    bcf	TRISD, PORTD_SDO2_POSN, A	; SDO2 output?
    bcf	TRISD, PORTD_SCK2_POSN, A	; SCK2 output?
    return ?
?
SPI_MasterTransmit:  ; Start transmission of data (held in W)?
	movwf 	SSP2BUF, A 	; write data to output buffer?
	call Wait_Transmit
	return
	
Wait_Transmit:	; Wait for transmission to complete ?
	btfss 	PIR2, 5		; check interrupt flag to see if data has been sent?
	bra 	Wait_Transmit?
	bcf 	PIR2, 5		; clear interrupt flag?
	movlw 0xFF
	movwf DelayCounter, A
	call Delay
	return 
Delay:
    decfsz DelayCounter, A
    bra Delay
    return
    ;checking if github works
    
start:	
	lfsr	0, myTable	; Load FSR0 with address in RAM	
	movlw	low highword(myTable)	; address of data in PM
	movwf	TBLPTRU, A	; load upper bits to TBLPTRU
	movlw	high(myTable)	; address of data in PM
	movwf	TBLPTRH, A	; load high byte to TBLPTRH
	movlw	low(myTable)	; address of data in PM
	movwf	TBLPTRL, A	; load low byte to TBLPTRL
	movlw	EndTable - StartTable	; Updates W with the length of the table
					; in memory
	movwf 	TableCounter, A	; our counter register
	
loop:
        tblrd*+			    ; move one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC0	; move read data from TABLAT to (FSR0), increment FSR0
	movf TABLAT, W, A
	call SPI_MasterTransmit
	decfsz	TableCounter, A	    ; count down to zero
	bra	loop		    ; keep going until finished
	

	
    end	main
	

    
    