;
;	ANSI Video handling for the NASCOM1/2
;
;	set it up with:
;	.text_cols	= max columns
;	.text_rows	= max rows
;
;	Display a char in location (ansi_ROW),(ansi_COLUMN)
;	A=char to display
;
;	Stefano Bodrato - Jul 2004
;
;
;	$Id: f_ansi_char.asm,v 1.2 2004/07/27 09:40:19 stefano Exp $
;

	XLIB	ansi_CHAR

	XDEF	text_cols
	XDEF	text_rows

	XREF	ansi_ROW
	XREF	ansi_COLUMN

.text_cols   defb 48
.text_rows   defb 16


.ansi_CHAR

	push	af
	ld	a,(ansi_ROW)
	ld	hl,0BCAh
	and	a
	jr	z,gotline

;	ld	hl,$84a
	ld	hl,$80a
	dec	a
	jr	z,gotline

	ld	de,64
.r_loop
	add	hl,de
	dec	a
	jr	nz,r_loop

.gotline
	ld	a,(ansi_COLUMN)
	ld	d,0
	ld	e,a
	add	hl,de
	pop	af
	ld	(hl),a

	;ld	a,(nascom_attr)

	ret
