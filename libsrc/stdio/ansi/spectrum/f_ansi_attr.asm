;
;       Spectrum C Library
;
; 	ANSI Video handling for ZX Spectrum
;
; 	Text Attributes
;	m - Set Graphic Rendition
;	
;	The most difficult thing to port:
;	Be careful here...
;
;	Stefano Bodrato - Apr. 2000
;
;
;	$Id: f_ansi_attr.asm,v 1.2 2001/04/13 14:13:59 stefano Exp $
;

	XLIB	ansi_attr

	XREF	INVRS

.ansi_attr
        and     a
        jr      nz,noreset
        ld      a,7
        ld      (23693),a
        ret
.noreset
        cp      1
        jr      nz,nobold
        ld      a,(23693)
        or      @01000000
        ld      (23693),a
        ret
.nobold
        cp      2
        jr      z,dim
        cp      8
        jr      nz,nodim
.dim
        ld      a,(23693)
        and     @10111111
        ld      (23693),a
        ret
.nodim
        cp      4
        jr      nz,nounderline
        ld      a,32
        ld      (INVRS+2),a   ; underline 1
        ret
.nounderline
        cp      24
        jr      nz,noCunderline
        ld      a, 24
        ld      (INVRS+2),a   ; underline 0
        ret
.noCunderline
        cp      5
        jr      nz,noblink
        ld      a,(23693)
        or      @10000000
        ld      (23693),a
        ret
.noblink
        cp      25
        jr      nz,nocblink
        ld      a,(23693)
        and     @01111111
        ld      (23693),a
        ret
.nocblink
        cp      7
        jr      nz,noreverse
        ld      a,47
        ld      (INVRS),a     ; inverse 1
        ret
.noreverse
        cp      27
        jr      nz,noCreverse
        xor     a
        ld      (INVRS),a      ; inverse 0
        ret
.noCreverse
        cp      8
        jr      nz,noinvis
        ld      a,(23693)
        ld      (oldattr),a
        and     @00111000
        ld      e,a
        rra
        rra
        rra
        or      e
        ld      (23693),a
        ret
.oldattr
        defb     0
.noinvis
        cp      28
        jr      nz,nocinvis
        ld      a,(oldattr)
        ld      (23693),a
        ret
.nocinvis
        cp      30
        jp      m,nofore
        cp      37+1
        jp      p,nofore
        sub     30
;'' Palette Handling ''
        rla
        bit     3,a
        jr      z,ZFR
        set     0,a
        and     7
.ZFR
;''''''''''''''''''''''
        ld      e,a
        ld      a,(23693)
        and     @11111000
        or      e
        ld      (23693),a
        ret
.nofore
        cp      40
        jp      m,noback
        cp      47+1
        jp      p,noback
        sub     40
;'' Palette Handling ''
        rla
        bit     3,a
        jr      z,ZBK
        set     0,a
        and     7
.ZBK
;''''''''''''''''''''''
        rla
        rla
        rla
        ld      e,a
        ld      a,(23693)
        and     @11000111
        or      e
        ld      (23693),a 
.noback
        ret
