;       Small C+ Math Library
;       fabs(x)



                XLIB    fabs
                LIB     minusfa


                LIB	sgn
                XREF    fa


;
.FABS  CALL    SGN
        RET     P
        jp      minusfa

