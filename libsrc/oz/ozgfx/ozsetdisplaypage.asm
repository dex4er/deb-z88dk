;
;	Sharp OZ family functions
;
;	ported from the OZ-7xx SDK by by Alexander R. Pruss
;	by Stefano Bodrato - Oct. 2003
;
;
;	gfx functions
;
;	Videmo memory page handling
;
;
; ------
; $Id: ozsetdisplaypage.asm,v 1.1 2003/10/23 10:42:50 stefano Exp $
;

	XLIB	ozsetdisplaypage


ozsetdisplaypage:
        pop     hl
        pop     bc
        push    bc
        ld      a,c
        or      a
        jr      nz,PageOneDisp
        xor     a
        out     (22h),a
;        ld      a,4
;        out     (23h),a      ;; removed as always 4
        jp      (hl)
PageOneDisp:
        ld      a,4
        out     (22h),a
;        out     (23h),a      ;; removed as always 4
        jp      (hl)
