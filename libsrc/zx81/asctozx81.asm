;
;	ZX 81 specific routines
;	by Stefano Bodrato, Oct 2007
;
; 	Internal code to convert a character from ASCII to ZX81
;	in: source character in (HL)
;	out: A = converted character
;
;	$Id: asctozx81.asm,v 1.1 2007/10/22 17:06:13 stefano Exp $
;

XLIB asctozx81
LIB zx81_cnvtab

.asctozx81

	ld	a,(hl)
	push	hl
 	cp	48	; Between 0 and 9 ?
	jr	c,isntnum
	cp	58
	jr	nc,isntnum
	sub	20	; Ok, re-code to the ZX81 charset
	jr	setout	; .. and put it out
.isntnum
	cp	97	; Between a and z ?
	jr	c,isntlower
	cp	123
	jr	nc,isntlower
	sub	32	; Then transform in UPPER !
.isntlower
	cp	65	; Between A and Z ?
	jr	c,isntchar
	cp	91
	jr	nc,isntchar
	sub	27	; Ok, re-code to the ZX81 charset
	jr	setout	; .. and put it out
.isntchar
	ld	hl,zx81_cnvtab
.symloop
	inc	hl
	cp	(hl)
	jr	z,chfound
	inc	hl
	push	af
	xor	a
	or	(hl)
	jr	z,isntsym
	pop	af
	jr	symloop
.chfound
	dec	hl
	ld	a,(hl)
	jr	setout
.isntsym
	pop	af
	ld	a,0	; Else (space, exclamation mark, ..), blank.

.setout
	pop	hl
	ret
