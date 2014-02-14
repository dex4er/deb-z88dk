;
;	ZX Spectrum OPUS DISCOVERY specific routines
;
;	Stefano Bodrato - Jun. 2006
;
;	int opus_getblocks (int drive);
;	
;	$Id: opus_getblocks.asm,v 1.1 2007/10/04 12:18:56 stefano Exp $
;


		XLIB 	opus_getblocks

		LIB	opus_rommap

		XREF	P_DEVICE
		

opus_getblocks:
		
		call	opus_rommap

		ld	ix,2
		add	ix,sp

		ld	hl,-1

		ld	a,(ix+0)	; drive
		and	a		; drive no. = 0 ?
		ret	z		; yes, return -1
		dec	a
		cp	5		; drive no. >5 ?
		ret	nc		; yes, return -1

		call	$1708		; Page in the Discovery ROM
		ld	a,(ix+0)	; drive
		ld	bc,$0400	; inquire disk
		call	P_DEVICE
		call	$1748		; Page out the Discovery ROM
					; HL = number of blocks
		ret
