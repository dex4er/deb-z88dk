; uchar __FASTCALL__ *zx_py2aaddr(uchar ycoord)
; aralbrec 06.2007

XLIB zx_py2aaddr

.zx_py2aaddr

   ld a,l
   rlca
   rlca
   ld h,a
   
   and $e0
   ld l,a
   
   ld a,h
   and $03
   or $58
   ld h,a
   
   ret
