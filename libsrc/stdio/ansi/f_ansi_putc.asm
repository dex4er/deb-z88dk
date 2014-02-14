;
;       Z80 ANSI Library
;
;---------------------------------------------------
;      Character output
;      x,y coordinates and LineFeed handling
;
;	Stefano Bodrato - 21/4/2000
;
;	$Id: f_ansi_putc.asm,v 1.2 2001/04/13 14:13:59 stefano Exp $
;

	XLIB	ansi_putc

	XREF	ansi_COLUMN

	XREF	text_cols

	LIB	ansi_CHAR
	LIB	ansi_LF


.ansi_putc
 
 call ansi_CHAR
 ld a,(text_cols)
 ld d,a
 ld a,(ansi_COLUMN)
 inc a
 ld (ansi_COLUMN),a
 cp d		; last column ?
 ret nz		; no, return
 jp ansi_LF

