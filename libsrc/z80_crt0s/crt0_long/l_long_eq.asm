;       Z88 Small C+ Run Time Library 
;       Long functions
;

XLIB    l_long_eq

;
; DEHL == secondary
; set carry if result true
; stack = secondary MSW, secondary LSW, ret

.l_long_eq

   pop ix                      ; return address
   
   pop bc                      ; secondary LSW
   ld a,c
   cp l
   jp nz, notequal0
   ld a,b
   cp h
   jp nz, notequal0
   
   pop bc                      ; secondary MSW
   ld a,c
   cp e
   jp nz, notequal1
   ld a,b
   cp d
   jp nz, notequal1
   
   scf
   jp (ix)

.notequal0

   pop bc

.notequal1

   or a
   jp (ix)

   
;        call    l_long_cmp
;        scf
;        ret   z
;	dec	hl
;	and	a
;        ret
