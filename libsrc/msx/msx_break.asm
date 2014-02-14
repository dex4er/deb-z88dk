;
;	MSX specific routines
;	by Stefano Bodrato, December 2007
;
;	int msx_break();
;
;	Checks if the Ctrl-STOP key is being pressed (1 = pressed, 0 = not pressed)
;
;
;	$Id: msx_break.asm,v 1.1 2007/12/13 11:28:42 stefano Exp $
;

	XLIB	msx_break
	LIB     msxbios
	
        INCLUDE "#msxbios.def"

msx_break:
	ld	ix,BREAKX
	call	msxbios
	sbc	a,a
	and	1	; if pressed, BREAKX returns $FF
	ld	h,0
	ld	l,a
	ret
