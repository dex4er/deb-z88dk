; $Id: bit_close_ei.asm,v 1.2 2002/04/17 21:30:24 dom Exp $
;
; Z88 1 bit sound functions
;
; Close sound and restore interrupts
;
; Stefano Bodrato - 28/9/2001
; Based on the Dominic Morris' code
;

    XLIB     bit_close_ei
    INCLUDE  "#interrpt.def"

    XREF     snd_asave

.bit_close_ei
          ld   a,(snd_asave)
          call oz_ei
          ret

