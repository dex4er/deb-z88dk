; void __CALLEE__ *ba_BestFit_callee(uchar q, uchar numq)
; 04.2004 aralbrec

XLIB ba_BestFit_callee
LIB BABestFit

.ba_BestFit_callee

   pop hl
   pop bc
   ld b,c
   ex (sp),hl
   ld h,0
   
   jp BABestFit
