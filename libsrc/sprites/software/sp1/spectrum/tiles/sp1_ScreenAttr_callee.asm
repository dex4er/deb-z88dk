; uchar__CALLEE__ sp1_ScreenAttr_callee(uchar row, uchar col)
; 02.2006 aralbrec, Sprite Pack v3.0
; sinclair spectrum version

XLIB sp1_ScreenAttr_callee
XDEF ASMDISP_SP1_SCREENATTR_CALLEE

LIB sp1_GetUpdateStruct_callee
XREF ASMDISP_SP1_GETUPDATESTRUCT_CALLEE

.sp1_ScreenAttr_callee

   pop hl
   pop de
   ex (sp),hl
   ld d,l

.asmentry

; Return colour at background coord given.
;
; enter : d = row coord
;         e = col coord
; exit  : hl = attr
; uses  : af, de, hl

.SP1ScreenAttr

   call sp1_GetUpdateStruct_callee + ASMDISP_SP1_GETUPDATESTRUCT_CALLEE

   inc hl
   ld l,(hl)
   ld h,0

   ret

DEFC ASMDISP_SP1_SCREENATTR_CALLEE = asmentry - sp1_ScreenAttr_callee
