; void *adt_QueueBack(struct adt_Queue *q)
; 09.2005 aralbrec

XLIB adt_QueueBack
LIB adt_QueueFront

; enter: HL = struct adt_Queue *
; exit : HL = peek at last item or 0 and carry reset if queue empty

.adt_QueueBack

   inc hl
   inc hl
   jp adt_QueueFront
