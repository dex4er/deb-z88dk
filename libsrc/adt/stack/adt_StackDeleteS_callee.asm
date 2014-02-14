; void __CALLEE__ adt_StackDeleteS_callee(struct adt_Stack *s, void *delete)
; 11.2006 aralbrec

XLIB adt_StackDeleteS_callee
XDEF ASMDISP_ADT_STACKDELETES_CALLEE

LIB l_jpix
XREF _u_free

.adt_StackDeleteS_callee

   pop hl
   pop de
   ex (sp),hl

.asmentry

; delete all items in stack but not adt_Stack struct itself
;
; enter: HL = struct adt_Stack *
;        DE = void (*delete)(void *item) with HL,stack=item

   ld a,h
   or l
   ret z
   
   ld a,d
   or e
   jp nz, notzero
   ld de,justret
   
.notzero

   ld ixl,e
   ld ixh,d

   inc hl
   inc hl
   ld e,(hl)
   inc hl
   ld d,(hl)
   ex de,hl                            ; hl = &adt_StackNode

.loop

   ld a,h
   or l
   ret z
   
   push hl                             ; save node address
   ld c,(hl)
   inc hl
   ld b,(hl)                           ; bc = item
   inc hl
   ld e,(hl)
   inc hl
   ld d,(hl)
   push de                             ; save next node
   ld l,c
   ld h,b
   push hl
   call l_jpix                         ; user delete function
   pop hl
   pop hl
   ex (sp),hl                          ; stack = next node, hl = current node
   push hl
   call _u_free                        ; free this node
   pop hl
   pop hl                              ; do it all again for next node
   jp loop

.justret

   ret

DEFC ASMDISP_ADT_STACKEDELETES_CALLEE = asmentry - adt_StackDeleteS_callee
