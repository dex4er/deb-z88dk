;
; 	ANSI Video handling for the Commodore 128 (Z80 mode)
;	By Stefano Bodrato - 22/08/2001
;
; 	Clean a text line
;
; in:	A = text row number
;
;
;	$Id: f_ansi_dline.asm,v 1.2 2002/04/17 21:30:26 dom Exp $
;


	XLIB	ansi_del_line


.ansi_del_line
	ld	hl,$400
	and	a
	jr	z,isz
	ld	de,40
.sum_loop
	add	hl,de
	dec	a
	jr	nz,sum_loop
.isz
	ld	b,39
.dlineloop
	ld	(hl),32
	inc	hl
	djnz	dlineloop
	ret
