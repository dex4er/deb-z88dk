;
;       Z88dk Z88 Maths Library
;
;
;       $Id: dge.asm,v 1.2 2002/12/12 10:11:55 dom Exp $

		XLIB	dge

		LIB	fsetup
		LIB	stkequcmp

		INCLUDE	"#fpp.def"

; TOS >= FA?
.dge
	call	fsetup
	fpp(FP_GEQ)
	jp	stkequcmp

