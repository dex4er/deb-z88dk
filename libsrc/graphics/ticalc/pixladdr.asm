
	XLIB	pixeladdress

	INCLUDE	"graphics/grafix.inc"

	XREF	base_graphics

;
;	$Id: pixladdr.asm,v 1.6 2002/04/17 21:30:25 dom Exp $
;

; ******************************************************************
;
; Get absolute	pixel address in map of virtual (x,y) coordinate.
;
; TI Calculator version
;
; addr=base+12*y+int(x/8)
;

.pixeladdress

		push	bc
		ld	a,h
		
		push	af
		
		srl	a
		srl	a
		srl	a
		
		ld	c,a	; c=int(x/8)
		
		;ld	b,l
		ld	h,0

; TI 82, 83 and 83+ screens are 12 bytes wide

IF FORti82
		ld	d,h
		ld	e,l
		add	hl,de
		add	hl,de
ENDIF

IF FORti83
		ld	d,h
		ld	e,l
		add	hl,de
		add	hl,de
ENDIF

IF FORti83p
		ld	d,h
		ld	e,l
		add	hl,de
		add	hl,de
ENDIF


; TI 85 and TI86 screens are 16 bytes wide

IF FORti85
		add	hl,hl
		add	hl,hl
ENDIF

IF FORti86
		add	hl,hl
		add	hl,hl
ENDIF

		add	hl,hl
		add	hl,hl
		
		ld	de,(base_graphics)
		add	hl,de
		
		ld	b,0
		
		add	hl,bc
		
		ld	d,h
		ld	e,l
		pop	af
		pop	bc
		
		and	@00000111		; a = x mod 8
		xor	@00000111		; a = 7 - a
		
		ret
