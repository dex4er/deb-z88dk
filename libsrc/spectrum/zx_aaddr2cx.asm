; uint __FASTCALL__ zx_aaddr2cx(void *attraddr)
; aralbrec 06.2007

XLIB zx_aaddr2cx

.zx_aaddr2cx

   ld a,l
   and $1f
   ld l,a
   ld h,0
   
   ret
