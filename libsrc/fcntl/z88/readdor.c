/*
 *	Read a member of a dor
 *
 *	readdor(int handle,char type,char len,void *buf)
 *
 *	djm 13/3/2000
 *
 * -----
 * $Id: readdor.c,v 1.3 2002/04/07 15:36:25 dom Exp $
 */


#include <z88.h>

void readdor(int handle, char type, char len, void *buf)
{
#asm
	INCLUDE	"#dor.def"
	ld	iy,0		;Use iy as framepointer for ease
	add	iy,sp
	ld	e,(iy+2)	;buffer
	ld	d,(iy+3)
	ld	c,(iy+4)	;length
	ld	b,(iy+6)	;type
	ld	l,(iy+8)	;dor handle
	ld	h,(iy+9)
	push	hl
	pop	ix		;os_dor wants it in ix
	ld	a,DR_Rd		;read dor
	call_oz(os_dor)
#endasm
}

