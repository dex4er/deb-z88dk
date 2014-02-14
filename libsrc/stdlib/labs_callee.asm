;
; Small C z88 stdlib functions
;
; Return absolute value of long
;
; -----
; $Id: labs_callee.asm,v 1.1 2007/01/10 08:17:06 aralbrec Exp $

XLIB labs_callee
LIB l_long_neg
XDEF ASMDISP_LABS_CALLEE

.labs_callee

   pop af
   pop hl
   pop de
   push af

.asmentry
   
   bit 7,d
   ret z
   
   jp l_long_neg

DEFC ASMDISP_LABS_CALLEE = asmentry - labs_callee
