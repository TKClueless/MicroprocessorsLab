	#include <xc.inc>
	global pop_table
	
	
	psect pop_count, class = CODE
	;Lookup table for determining nibble pop count
	pop_table:
	ADDWF PCL, A
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
	
	psect ascii_lookup, class = Code
	
	;ascii_table:
	;addwf pcl
	;retlw 0x
	
	
	
	
	
