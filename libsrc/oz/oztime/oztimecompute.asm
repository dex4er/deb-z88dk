;
;	Sharp OZ family functions
;
;	ported from the OZ-7xx SDK by by Alexander R. Pruss
;	by Stefano Bodrato - Oct. 2003
;
;
;	clock functions
;
;
; ------
; $Id: oztimecompute.asm,v 1.1 2003/10/21 17:15:22 stefano Exp $
;

	XLIB	Compute
	

Compute:
        in      a,(c)
        and     0fh
        add     a,a
        ld      b,a
        add     a,a
        add     a,a
        add     a,b
        ld      b,a      ; b=10*(c)
        dec     c
        in      a,(c)
        and     0fh
        add     a,b
        ld      l,a
        ld      h,0
        ret
