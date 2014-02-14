;
;
;       ZX Maths Routines
;
;       8/1/03 - Stefano Bodrato
;
;       $Id: minusfa.asm,v 1.1 2003/03/24 09:17:40 stefano Exp $
;
;       Negate a floating point number
;
;	Strangely the generic minusfa function doesn't do the job for me !
;	I had to write this small function, but this means that probably
;	this FP format differs slightly from the generic one
;


IF FORzx
		INCLUDE  "#zxfp.def"
ELSE
		INCLUDE  "#81fp.def"
ENDIF


                XLIB    minusfa

                XREF    fa

.MINUSFA LD     HL,FA+4
        LD      A,(HL)
        XOR     $80
        LD      (HL),A
        RET

;                XLIB    minusfa
;
;                LIB	fsetup1
;                LIB	stkequ
;
;.minusfa
;        call    fsetup1
;	defb	ZXFP_NEGATE
;	defb	ZXFP_END_CALC
;        jp      stkequ
;
