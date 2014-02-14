;
;       Sprinter C Library
;
; 	ANSI Video handling for Sprinter
;
; 	CLS - Clear the screen
;	
;
;	Stefano Bodrato - Apr. 2000
;
;
;	$Id: f_ansi_cls.asm,v 1.2 2002/10/10 22:03:26 dom Exp $
;

	XLIB	ansi_cls

.ansi_cls
	ld	d,0		;top left x
	ld	e,0		;top left y
	ld	h,32		;height
	ld	l,80		;depth
	xor	a		;fill character
	ld	b,7		;clear colour?
	ld	c,$57		;CLEAR
	rst	$10
	ret
	
