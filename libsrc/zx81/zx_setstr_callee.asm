;
;	ZX 81 specific routines
;	by Stefano Bodrato, Oct 2007
;
;	Copy a string to a BASIC variable
;
;	int __CALLEE__ zx_setstr_callee(char variable, char *value);
;
;
;	$Id: zx_setstr_callee.asm,v 1.2 2007/10/23 20:33:49 stefano Exp $
;

XLIB	zx_setstr_callee
XDEF	ASMDISP_ZX_SETSTR_CALLEE
LIB	asctozx81

zx_setstr_callee:

	pop	bc
	pop	hl
	pop	de
	push	bc

; enter : hl = char *value
;          e = char variable

.asmentry
	
	ld	a,e
	and	31
	add	69

	
	ld	(morevar+1),a
	ld	(pointer+1),hl
	
	ld	hl,($4010) 		; VARS
	
loop:

	ld	a,(hl)
	cp	128
	jr	nz,morevar
	
	jr	store			; variable not found
	
morevar:

	cp	0
	jr	nz,nextvar
	
	call	$09F2			; get next variable start
	call	$0A60			; reclaim space (delete)
	
store:

	ld	bc,0

pointer:

	ld	de,0			; point to the string
	push	de

lenloop:

	inc	bc			; string length counter
	inc	de
	ld	a,(de)
	and	a
	jr	nz,lenloop
	
	push	hl
	push	bc	
	inc	bc
	inc	bc
	inc	bc
	call	$099E			; MAKE-ROOM
	pop	bc
	pop	hl
	
	ld	a,(morevar+1)
	ld	(hl),a
	inc	hl
	ld	(hl),c
	inc	hl
	ld	(hl),b
	inc	hl
	pop	de
	
	ex	de,hl
	;ldir
;-----------------------------
.outloop
	call	asctozx81
	ld	(de),a
	inc	hl
	inc	de
	dec	bc
	ld	a,b
	or	c
	jr	nz,outloop
;------------------------------

	ret
	
nextvar:

	call	$09F2			;get next variable start
	ex	de,hl
	jr	loop

DEFC ASMDISP_ZX_SETSTR_CALLEE = asmentry - zx_setstr_callee
