; void sp1_SetPrintPos(struct sp1_pss *ps, uchar row, uchar col)
; CALLER linkage for function pointers

XLIB sp1_SetPrintPos

LIB sp1_SetPrintPos_callee
XREF ASMDISP_SP1_SETPRINTPOS_CALLEE

.sp1_SetPrintPos

   ld hl,2
   add hl,sp
   ld e,(hl)
   inc hl
   inc hl
   ld d,(hl)
   inc hl
   inc hl
   ld a,(hl)
   inc hl
   ld h,(hl)
   ld l,a
   
   jp sp1_SetPrintPos_callee + ASMDISP_SP1_SETPRINTPOS_CALLEE
