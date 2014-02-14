;
;	ZX81 clock() function
;	By Stefano Bodrato - summer 2000
;
; --------
; $Id: clock.asm,v 1.4 2002/04/17 21:30:26 dom Exp $


	XLIB	clock

.clock
; 16436/7 word running backwards from 65535 to 32768 (bit 15 always set).
; It is reset by basic if running a PAUSE statement.

	ld	hl,65535
	ld	de,(16436)
	scf
	ccf
	sbc	hl,de
	ld	de,0
	ret
