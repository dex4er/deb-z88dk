;
; Z88 Runtime library
;
; Moved from z88_crt0.asm to library function
;

                XLIB     l_div



IF !ARCHAIC

                
; The old routine was so cumbersome, so come up with a new one which
; will hopefully be a lot quicker and nicer!

; hl = hl/de   de= hl % de - signed!

;oops, it's the other way round!
; hl = de/hl   de=de % hl - hence the ex de,hl as first line!

.l_div
; Check for dividing by zero beforehand
        ld      a,h
        or      l
        ret     z
        ex      de,hl
;First have to obtain signs for quotient and remainder
        ld      a,h     ;dividend
        and     128
        ld      b,a     ;keep it safe
        jr      z,l_div0
;if -ve make into positive number!
        sub     a
        sub     l
        ld      l,a
        sbc     a,a
        sub     h
        ld      h,a
.l_div0
        ld      a,d     ;divisor
        and     128
        xor     b       
        ld      c,a     ;keep it safe (Quotient)
        bit     7,d
        jr      z,l_div01
        sub     a
        sub     e
        ld      e,a
        sbc     a,a
        sub     d
        ld      d,a
.l_div01
;Check for dividing by zero...
        ex      de,hl
        ld      a,h
        or      l
        ret     z       ;return hl=0, de=divisor
        ex      de,hl
        push    bc      ;keep the signs safe
;Now, we have two positive numbers so can do division no problems..
        ld      a,16    ;counter
        ld      b,h     ;arg1
        ld      c,l
        ld      hl,0    ;res1
; hl=res1 de=arg2 bc=arg1
        and     a
.l_div1
        rl      c       ;arg1 << 1 -> arg1
        rl      b
        rl      l       ;res1 << 1 -> res1
        rl      h
        sbc     hl,de   ;res1 - arg2 -> res1
        jr      nc,l_div2
        add     hl,de   ;res1 + arg2 -> res1
.l_div2
        ccf
        dec     a
        jr      nz,l_div1
        rl      c       ;arg1 << 1 -> arg1
        rl      b
;Have to return arg1 in hl and res1 in de
        ld      d,b
        ld      e,c
;Now do the signs..
        pop     bc      ;c holds quotient, b holds remainder
;de holds quotient, hl holds remainder
        ld      a,c
        call    dosign  ;quotient
        ld      a,b
        ex      de,hl   ;remainder (into de)
;Do the signs - de holds number to sign, a holds sign
.dosign
        and     128
        ret     z       ;not negative so okay..
        sub     a
        sub     e
        ld      e,a
        sbc     a,a
        sub     d
        ld      d,a
        ret

ENDIF




IF ARCHAIC


;These are now in libraries!
                LIB     l_deneg
                LIB     l_bcneg


; HL = DE / HL, DE = DE % HL

.l_div 
        ld b,h
        ld c,l
        ld a,d
        xor   b
        push  af
        call    m,l_deneg
;      call CALL_
;   .dw cm_de
        call  m,l_bcneg       ; ZShell mod
;   call CALL_
;   .dw cm_bc
        ld a,16
        push  af
        ex de,hl
        ld de,0
.l_div1   
        add   hl,hl
; {DE <r<r 1}
.l_rdel   
        ld a,e
        rla
        ld e,a
        ld a,d
        rla
        ld d,a
        or e
        jr z,l_div2
; {BC : DE}
.l_cmpbd 
        ld  a,e
        sub   c
        ld a,d
        sbc   a,b
        jp m,l_div2               ; ZShell mod
        ld a,l
        or 1
        ld l,a
        ld a,e
        sub   c
        ld e,a
        ld a,d
        sbc   a,b
        ld d,a
.l_div2   
        pop   af
        dec   a
        jr z,l_div3
        push  af
        jr l_div1
.l_div3   
        pop   af
        ret   p
        call  l_deneg
        ex de,hl
        call  l_deneg
        ex de,hl
        ret

ENDIF