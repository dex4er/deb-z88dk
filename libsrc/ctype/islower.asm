;
;	Small C z88 Character functions
;	Written by Dominic Morris <djm@jb.man.ac.uk>
;	22 August 1998
;
;	17/2/99 djm Rewritten to remove the jp and thus be shorter
;
;	$Id: islower.asm,v 1.2 2001/04/17 08:05:14 stefano Exp $
;

                XLIB    islower


;islower (c) char c
;return address, c

.islower
        ld      hl,2
        add     hl,sp
        ld      a,(hl)
	ld	hl,0	; failed
        cp      'a'
	ret	c
        cp      'z'+1
	ret	nc
	inc	hl	; success
        ret
