;       Z88 Small C+ Run time Library
;       Moved functions over to proper libdefs
;       To make startup code smaller and neater!
;
;       6/9/98  djm

                XLIB    l_lt
                LIB     l_cmp

;
;......logical operations: HL set to 0 (false) or 1 (true)
;
; DE < HL [signed]
.l_lt
        call    l_cmp
        ret     c
        ret


