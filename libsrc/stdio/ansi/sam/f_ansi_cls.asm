;
;       SAM Coup� C Library
;
; 	ANSI Video handling for SAM Coup�
;
; 	CLS - Clear the screen
;	
;
;	Frode Tenneb� - 29/12/2002
;
;
;	$Id: f_ansi_cls.asm,v 1.1 2003/02/04 09:10:23 stefano Exp $
;

	XLIB	ansi_cls

.ansi_cls
 	xor	a
	jp	$014E
