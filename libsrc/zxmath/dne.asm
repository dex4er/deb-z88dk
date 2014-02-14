;
;
;       ZX Maths Routines
;
;       9/12/02 - Stefano Bodrato
;
;       $Id: dne.asm,v 1.2 2006/05/24 18:06:34 stefano Exp $
;


IF FORzx
		INCLUDE  "#zxfp.def"
ELSE
		INCLUDE  "#81fp.def"
ENDIF

                XLIB    dne

                LIB	fsetup
                LIB	f_yesno

.dne
        call    fsetup
	defb	ZXFP_SUBTRACT
	defb	ZXFP_NOT
	defb	ZXFP_NOT
	defb	ZXFP_END_CALC
	
	jp	f_yesno