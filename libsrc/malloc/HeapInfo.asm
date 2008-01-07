; CALLER linkage for function pointers

XLIB HeapInfo
LIB MAHeapInfo

.HeapInfo

   pop af
   pop hl
   ex af,af
   call MAHeapInfo
   pop hl
   ld (hl),c
   inc hl
   ld (hl),b
   pop hl
   ld (hl),e
   inc hl
   ld (hl),d
   push hl
   push hl
   push hl
   ex af,af
   push af
   ret
