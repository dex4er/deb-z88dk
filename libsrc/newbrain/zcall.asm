;
; Grundy Newbrain Specific libraries
;
; Stefano Bodrato - 19/05/2007
;
;
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;
; This function is linked only in the non-CP/M version
; it calls the ROM functions via the standard rst entry
;
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;
; Used internally only
;
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;
;
; $Id: zcall.asm,v 1.1 2007/06/03 15:13:06 stefano Exp $
;


	XLIB ZCALL
	
.ZCALL
	jp	$20	; ZCALL

