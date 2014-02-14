;
;       Z88dk Generic Floating Point Math Library
;
;       Multiply fa y bc ix de
;
;       $Id: fmul.asm,v 1.1 2002/01/21 20:35:22 dom Exp $:


		XLIB	fmul

		LIB	sgn
		LIB	div14
		LIB	norm

		XREF	fa


.FMUL   CALL    SGN
        RET     Z       ; z => accumulator has zero
        LD      L,0     ;"product" flag
        CALL    DIV14   ;find exponent of product
        LD      A,C  ;c' h'l' d'e' (multiplicand) = c ix de...
        PUSH    DE
        EXX
        LD      C,A
        POP     DE
        PUSH    IX
        POP     HL
        EXX             ;...end of multiplicand loading
        LD      BC,0    ; c ix de b (product) = 0...
        LD      D,B
        LD      E,B
        LD      IX,0
        LD      HL,NORM ; push addr of normalize routine
        PUSH    HL
        LD      HL,MULLOOP      ; push addr of top of loop
        PUSH    HL      ; (5 iterations wanted,
        PUSH    HL      ; once per byte of fraction)
        PUSH    HL
        PUSH    HL
        LD      HL,FA   ;point to LSB
.MULLOOP LD     A,(HL)  ;get next byte of multiplier
        INC     HL
        OR      A
        JR      NZ,MUL2 ; z => next 8 bits of multiplier are 0
        LD      B,E     ;shift  c ix de b  right by 8...
        LD      E,D
        DEFB    $DD
        LD      D,L
        EX      AF,AF'
        DEFB    $DD
        LD      A,H
        DEFB    $DD
        LD      L,A
        EX      AF,AF'
        DEFB    $DD
        LD      H,C
        LD      C,A     ;...end of shifting
        RET             ;go to top of loop or NORM
;
.MUL2   PUSH    HL      ;save multiplier pointer
        EX      DE,HL
        LD      E,8     ;8 iterations (once per bit)
.MUL4   RRA             ;rotate a multiplier bit into cy
        LD      D,A
        LD      A,C
        JR      NC,MUL6 ; nc => no addition needed
        PUSH    HL      ; c ix hl (product)  +=
        EXX             ;       c' h'l' d'e' (multiplicand)
        EX      (SP),HL
        ADD     HL,DE
        EX      (SP),HL
        EX      DE,HL
        PUSH    IX
        EX      (SP),HL
        ADC     HL,DE
        EX      (SP),HL
        POP     IX
        EX      DE,HL
        ADC     A,C
        EXX
        POP     HL
;
.MUL6   RRA        ;shift  c ix hl b (product)  right by 1...
        LD      C,A
        DEFB    $DD
        LD      A,H
        RRA
        DEFB    $DD
        LD      H,A
        DEFB    $DD
        LD      A,L
        RRA
        DEFB    $DD
        LD      L,A
        RR      H
        RR      L
        RR      B               ;...end of shifting
        DEC     E
        LD      A,D
        JR      NZ,MUL4         ; z => 8 iterations complete
        EX      DE,HL
.MUL8   POP     HL              ;recover multiplier pointer
        RET                     ;go to top of loop or NORM


