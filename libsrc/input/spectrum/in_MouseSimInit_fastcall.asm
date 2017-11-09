; void __FASTCALL__ in_MouseSimInit_fastcall(struct in_UDM *u)
; 09.2005 aralbrec

; mainly for symmetry with AMX mouse functions

XLIB in_MouseSimInit_fastcall
LIB l_setmem

.in_MouseSimInit_fastcall

; just set initial coordinates to (0,0) and reset state machine
; enter: HL = struct in_UDM *
; uses : AF,DE,HL

   ld de,6
   add hl,de
   xor a
   jp l_setmem-11
