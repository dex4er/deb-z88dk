;       Small C+ Math Library - Support routine
;       Negate a fp number push address

                XLIB    odd
                LIB     minusfa

;
;       negate FA, and push address of MINUSFA
;       called to evaluate functions f(x) when the argument is
;       negative and f() satisfies f(-x)=-f(x)
.ODD    CALL    MINUSFA
        LD      HL,MINUSFA
        EX      (SP),HL
        JP      (HL)
;

