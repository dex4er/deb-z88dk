;
;	Put character to console
;
;	fputc_cons(char c)
;
;
;	$Id: fputc_cons.asm,v 1.1 2007/10/07 17:49:34 dom Exp $
;


		XLIB	fputc_cons

		INCLUDE	"#test_cmds.def"

.fputc_cons
	ld	hl,2
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	a,CMD_PRINTCHAR
	rst	8
	ret

