
/*
 *	Open a titled window
 *
 *	GWL 26/3/00
 */

#include <z88.h>

void opentitled(int wid,int tlx,int tly,int width,int height,char *name)
{
#asm
	include	"#stdio.def"
	LIB	opwin

	ld	ix,2		; IX points to name
	add	ix,sp
	ld	b,131		; with shelf brackets
	call	opwin
	ld	hl,winban
	call_oz(gn_sop)		; banner setup string
	ld	l,(ix+0)
	ld	h,(ix+1)
	call_oz(gn_sop)		; display title
	ld	hl,winapl
	call_oz(gn_sop)		; apply effects
	ld	a,(ix+4)
	add	a,'0'
	call_oz(os_out)		; across whole width
	inc	(ix+6)		; increment start row
	dec	(ix+2)		; decrement height
	ld	b,129		; left/right bars only
	call	opwin		; re-define

#endasm
}

#asm

.winban	defm	1&"4+TUR"&1&"2JC"&0	; banner setup string
.winapl	defm	1&"3@  "&1&"2A"&0	; apply effects string

#endasm

