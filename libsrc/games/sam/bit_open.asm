; $Id: bit_open.asm,v 1.1 2003/02/04 09:10:18 stefano Exp $
;
; ZX Spectrum 1 bit sound functions
;
; void bit_open();
;
; Stefano Bodrato - 28/9/2001
;

    XLIB     bit_open
    XREF     snd_tick

.bit_open
          ld    a,(23624)  
          rrca
          rrca
          rrca
          or	8
          ld   (snd_tick),a
          ret
