; uint __FASTCALL__ zx_aaddr2cy(void *attraddr)
; aralbrec 06.2007

XLIB zx_aaddr2cy

.zx_aaddr2cy

   add hl,hl
   add hl,hl
   add hl,hl
   ld a,h
   and $1f
   ld l,a
   ld h,0
   
   ret
