; void __CALLEE__ ldiv_callee(ldiv_t *d, long num, long denom)
; 12.2006 aralbrec

XLIB ldiv_callee
LIB l_long_div

.ldiv_callee

   ; setup for l_long_div: dehl = denom, stack = num
   
   pop af
   ex af,af                 ; af' = return address

   pop hl
   pop de
   call l_long_div          ; dehl = q, de'hl' = r
   ex de,hl
   ex (sp),hl               ; hl = ldiv_t *
   ld (hl),e
   inc hl
   ld (hl),d
   inc hl
   pop de
   ld (hl),e
   inc hl
   ld (hl),d
   inc hl
   push hl
   exx
   ex de,hl
   ex (sp),hl
   ld (hl),e
   inc hl
   ld (hl),d
   inc hl
   pop de
   ld (hl),e
   inc hl
   ld (hl),d

   ex af,af
   push af
   ret
