	#include <xc.inc>
	global pop_table
	
	;psect udata_
	psect pop_count, class = CODE
	;Lookup table for determining nibble pop count
	
	;lookup_selection:  ;set certain bits and use those to select appropriate lookup table
	;bit check the lookup select byte for appropriate flag
	
	pop_table:
	ADDWF PCL
	retlw 0
	retlw 1
	retlw 1
	retlw 1
	retlw 1
	retlw 2
	retlw 2
	retlw 2
	retlw 2
	retlw 3
	retlw 3
	retlw 3
	retlw 3
	retlw 4
	retlw 4
	retlw 4
	retlw 4
	
	;psect ascii_lookup, class = Code
	
	;ascii_table:
	;IF WREG =	;   ASCII characters for:
	;retlw	0x31	;   "1"
;	retlw	0x32	;   "2"
;	retlw	0x33	;   "3"
;	retlw	0x46	;   "F"
;	retlw	0x34	;   "4"
;	retlw	0x35	;   "5"
;	retlw	0x36	;   "6"
;	retlw	0x45	;   "E"
;	retlw	0x37	;   "7"
;	retlw	0x38	;   "8"
;	retlw	0x39	;   "9"
;	retlw	0x44	;   "D"
;	retlw	0x41	;   "A"
;	retlw	0x30	;   "0"
;	retlw	0x42	;   "B"
;	retlw	0x43	;   "C"
		

	
	
	
