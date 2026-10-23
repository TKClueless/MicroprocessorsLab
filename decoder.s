	#include <xc.inc>
	global pop_table
	
	;psect udata_
	psect pop_count, class = CODE
	;Lookup table for determining nibble pop count
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
	;IF WREG = 
	;
	
	
	
	
	
