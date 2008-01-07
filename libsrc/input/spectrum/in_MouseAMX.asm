; void in_MouseAMX(uchar *buttons, uint *xcoord, uint *ycoord)
; CALLER linkage for function pointers

XLIB in_MouseAMX
LIB INMouseAMX

.in_MouseAMX

   call INMouseAMX
   pop de
   pop hl
   ld (hl),a
   inc hl
   xor a
   ld (hl),a
   pop hl
   ld (hl),b
   inc hl
   ld (hl),a
   pop hl
   ld (hl),c
   
   push hl
   push hl
   push hl
   ex de,hl
   jp (hl)
