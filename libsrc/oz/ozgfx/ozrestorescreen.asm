;
;	Sharp OZ family functions
;
;	ported from the OZ-7xx SDK by by Alexander R. Pruss
;	by Stefano Bodrato - Oct. 2003
;
;
;
;
; ------
; $Id: ozrestorescreen.asm,v 1.1 2003/10/21 17:15:20 stefano Exp $
;

	XLIB	ozrestorescreen
	
	XREF	ozsccopy
	
	XREF	ozactivepage


.ozrestorescreen
        ld      de,968h
        push    de
        ld      hl,0
        push    hl
        ld      h,4  ;; l=0 still
        ld      de,(ozactivepage)
        jp      ozsccopy

