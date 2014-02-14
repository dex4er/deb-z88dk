;
;       Z88dk Generic Floating Point Math Library
;
;       Exchange FA with top of stack (under ret address)
;
;	$Id: dswap.asm,v 1.1 2002/01/21 20:35:22 dom Exp $


		XLIB	dswap
		
		LIB	ldfabc

		XREF	dpush

.DSWAP  POP     HL      ;return addr
        POP     DE
        POP     IX
        POP     BC
        EXX             ;protect the values
        CALL    DPUSH   ;push FA
        EXX             ;recover the values
        PUSH    HL      ;replace return addr, fall into...
        jp      ldfabc


