; CALLER LINKAGE FOR FUNCTION POINTERS

XLIB vz_score
LIB vz_score_callee
XREF ASMDISP_VZ_SCORE_CALLEE

.vz_score

   pop hl
   pop bc
   pop de
   push de
   push bc
   push hl
   
   jp vz_score_callee + ASMDISP_VZ_SCORE_CALLEE
