;
; 	ANSI Video handling for the Commodore 128 (Z80 mode)
;	By Stefano Bodrato - 22/08/2001
;
; 	CLS - Clear the screen
;	
;
;	$Id: f_ansi_cls.asm,v 1.3 2002/04/17 21:30:26 dom Exp $
;

	XLIB	ansi_cls

.ansi_cls
	ld	hl,$2000	; Text
	ld	d,h
	ld	e,l
	inc	de
	ld	bc,1023
	ld	(hl),32
	ldir
	ld	hl,$1000	; Color attributes
	ld	d,h
	ld	e,l
	inc	de
	ld	bc,1023
	ld	(hl),1
	ldir
	ret
