;
; 	ANSI Video handling for the Jupiter ACE
;
;	Stefano Bodrato - Feb. 2001
;
;
;	set it up with:
;	.text_cols	= max columns
;	.text_rows	= max rows
;
;	Display a char in location (ansi_ROW),(ansi_COLUMN)
;	A=char to display
;
;
;	$Id: f_ansi_char.asm,v 1.4 2001/10/22 09:33:55 stefano Exp $
;

	XLIB	ansi_CHAR
	
	XDEF	text_cols
	XDEF	text_rows

	XREF	ansi_ROW
	XREF	ansi_COLUMN
	
	XREF	ace_inverse


.text_cols   defb 32
.text_rows   defb 24


.ansi_CHAR

	ld	hl,ace_inverse
	or	(hl)

.setout
	push	af
	ld	hl,$2400
	ld	a,(ansi_ROW)
	and	a
	jr	z,r_zero
	ld	b,a
	ld	de,32
.r_loop
	add	hl,de
	djnz	r_loop
.r_zero
	ld	a,(ansi_COLUMN)
	ld	d,0
	ld	e,a
	add	hl,de
	pop	af
	ld	(hl),a
	ret

