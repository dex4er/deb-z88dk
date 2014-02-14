;
; 	ANSI Video handling for the TI calculators
;	By Stefano Bodrato - Dec. 2000
;
;	Scrollup
;
;
;	$Id: f_ansi_scrollup.asm,v 1.5 2002/04/17 21:30:26 dom Exp $
;

	INCLUDE	"stdio/ansi/ticalc/ticalc.inc"

	XLIB	ansi_SCROLLUP
	XREF	base_graphics
	XREF	TIdi
	XREF	TIei
	LIB	ansi_del_line
	LIB	fgetc_cons

.ansi_SCROLLUP

; These are called before scrolling: we wait for any keypress.
; We don't use getkey when possible.

	call	TIei
	
IF FORti82
.kloop
	ld	hl,$8004
	bit	2,(hl)
	jr	z,kloop
ENDIF

IF FORti83	; Thanks to Red Picasso (Brandon Whaley) for his dirinput.inc
; We use getkey to wait for a key

.kloop
	ld	hl,krowptr
.kloop1
	ld      a,$ff	; Reset the keyport (kinda)
	out     (1),a
	ld      a,(hl)
	and	a
	jr	z,kloop
	out     (1),a
	in      a,(1)
	cp	255
	jr      nz,kok
	inc	hl
	jr	kloop1
.krowptr
	defb	$fe
	defb	$fd
	defb	$fb
	defb	$f7
	defb	$ef
	defb	$df
	defb	$bf
	defb	0
.kok
ENDIF

IF FORti83p
.kloop
	ld	a,($843F) ; Keyboard ScanCODE address
	and	a
	jr	z,kloop
ENDIF

IF FORti85
.kloop
	ld	a,($8001)
	and	a
	jr	z,kloop
ENDIF

IF FORti86
; We use getkey to wait for a key
.kloop
	call	getkey
	and	a
	jr	z,kloop
ENDIF

	call	TIdi

  	ld	hl,8*row_bytes
  	ld	de,(base_graphics)
	add	hl,de
	ld	bc,row_bytes*8*7
	ldir
	
	ld	a,7
	jp	ansi_del_line
