;
;	System Call for REX6000
;
;	$Id: syscall3.asm,v 1.4 2002/04/17 21:30:25 dom Exp $
;

		XLIB	syscall3


.syscall3
	ld	ix,2
	add	ix,sp
	ld	l,(ix+0)	;par 3
	ld	h,(ix+1)
	ld	($c006),hl
	ld	l,(ix+2)	;par 2
	ld	h,(ix+3)
	ld	($c004),hl
	ld	l,(ix+4)	;par 1
	ld	h,(ix+5)
	ld	($c002),hl
	ld	l,(ix+6)	;call
	ld	h,(ix+7)
	ld	($c000),hl
	rst	$10
	ld	hl,($c00e)
	ret


