;
;	Sharp OZ family functions
;
;	ported from the OZ-7xx SDK by by Alexander R. Pruss
;	by Stefano Bodrato - Oct. 2003
;
;
;	restore the page A000
;
;
; ------
; $Id: restore_a000.asm,v 1.1 2003/10/21 17:15:19 stefano Exp $
;

	XLIB	restore_a000
	
restore_a000:
        ld      a,7
        out     (3),a
        ld      a,4
        out     (4),a
        ret
