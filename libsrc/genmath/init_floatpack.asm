;
;	CPC Maths Routines
;
;	August 2003 **_|warp6|_** <kbaccam /at/ free.fr>
;
;	$Id: init_floatpack.asm,v 1.1 2003/08/30 16:43:35 dom Exp $
;

		INCLUDE		"#cpcfp.def"

		XLIB		init_floatpack

; All the library routines that we have to change
                LIB             atan
                LIB             cos
                LIB             dadd
                LIB             ddiv
                LIB             deg
                LIB             deq
                LIB             dge
                LIB             dgt
                LIB             dleq
                LIB             dlt
                LIB             dmul
                LIB             dne
                LIB             dsub
                LIB             exp
                LIB             float
                LIB             floor
                LIB             fprand
                LIB             ifix
                LIB             log10
                LIB             log
                LIB             minusfa
                LIB             pi
                LIB             pow10
                LIB             pow
                LIB             rad
                LIB             sin
                LIB             sqrt
                LIB             tan

; The actual place where we have to change things
                XREF            atanc
                XREF            cosc
                XREF            daddc
                XREF            ddivc
                XREF            degc
                XREF            deqc
                XREF            dgec
                XREF            dgtc
                XREF            dleqc
                XREF            dltc
                XREF            dmulc
                XREF            dnec
                XREF            dsubc
                XREF            expc
                XREF            floatc
                XREF            floorc
                XREF            floorc2
                XREF            fprandc
                XREF            ifixc
                XREF            log10c
                XREF            logc
                XREF            minusfac
                XREF            pic
                XREF            pow10c
                XREF            powc
                XREF            radc
                XREF            sinc
                XREF            skelc
                XREF            sqrtc
                XREF            tanc

; Now, a hack around z80asm - we have to reference the .lib labels to get
; them into scope. Ideally we'd go (libroutine+offset), but the offset may
; change at some point and this is arguable the simplest way to do it
;
; We save space by only using defb - this overflow, but no harm done there

                defb    atan
                defb    cos
                defb    dadd
                defb    ddiv
                defb    deg
                defb    deq
                defb    dge
                defb    dgt
                defb    dleq
                defb    dlt
                defb    dmul
                defb    dne
                defb    dsub
                defb    exp
                defb    float
                defb    floor
                defb    fprand
                defb    ifix
                defb    log10
                defb    log
                defb    minusfa
                defb    pi
                defb    pow10
                defb    pow
                defb    rad
                defb    sin
                defb    sqrt
                defb    tan


.init_cpcfloat
		ld	hl,$BD65
		ld	a,(hl)
		cp	158
		jp	z,init_cpc464float
		cp	200
		jp	z,init_cpc664float
		ret

.init_cpc464float
		ld	hl,CPCFP464_FLO_ATAN
                ld      (atanc+1),hl
		ld	hl,CPCFP464_FLO_COS
                ld      (cosc+1),hl
		ld	hl,CPCFP464_FLO_ADD
                ld      (daddc+1),hl
		ld	hl,CPCFP464_FLO_DIV
                ld      (ddivc+1),hl
		ld	hl,CPCFP464_FLO_DEG_RAD
                ld      (degc+1),hl
                ld      (radc+1),hl
		ld	hl,CPCFP464_FLO_CMP
                ld      (deqc+1),hl
                ld      (dgec+1),hl
                ld      (dgtc+1),hl
                ld      (dleqc+1),hl
                ld      (dltc+1),hl
                ld      (dnec+1),hl
		ld	hl,CPCFP464_FLO_MUL
                ld      (dmulc+1),hl
		ld	hl,CPCFP464_FLO_REV_SUB
                ld      (dsubc+1),hl
		ld	hl,CPCFP464_FLO_EXP
                ld      (expc+1),hl
		ld	hl,CPCFP464_INT_2_FLO
                ld      (floatc+1),hl
		ld	hl,CPCFP464_FLO_BINFIX
                ld      (floorc+1),hl
		ld	hl,CPCFP464_BIN_2_FLO
                ld      (floorc2+1),hl
		ld	hl,CPCFP464_FLO_RND
                ld      (fprandc+1),hl
		ld	hl,CPCFP464_FLO_2_INT
                ld      (ifixc+1),hl
		ld	hl,CPCFP464_FLO_LOG10
                ld      (log10c+1),hl
		ld	hl,CPCFP464_FLO_LOG
                ld      (logc+1),hl
		ld	hl,CPCFP464_FLO_INV_SGN
                ld      (minusfac+1),hl
		ld	hl,CPCFP464_FLO_PI
                ld      (pic+1),hl
		ld	hl,CPCFP464_FLO_POW10
                ld      (pow10c+1),hl
		ld	hl,CPCFP464_FLO_POW
                ld      (powc+1),hl
		ld	hl,CPCFP464_FLO_SIN
                ld      (sinc+1),hl
		ld	hl,CPCFP464_FLO_SQRT
                ld      (sqrtc+1),hl
		ld	hl,CPCFP464_FLO_TAN
                ld      (tanc+1),hl
		ret

.init_cpc664float
		ld	hl,CPCFP664_FLO_ATAN
                ld      (atanc+1),hl
		ld	hl,CPCFP664_FLO_COS
                ld      (cosc+1),hl
		ld	hl,CPCFP664_FLO_ADD
                ld      (daddc+1),hl
		ld	hl,CPCFP664_FLO_DIV
                ld      (ddivc+1),hl
		ld	hl,CPCFP664_FLO_DEG_RAD
                ld      (degc+1),hl
                ld      (radc+1),hl
		ld	hl,CPCFP664_FLO_CMP
                ld      (deqc+1),hl
                ld      (dgec+1),hl
                ld      (dgtc+1),hl
                ld      (dleqc+1),hl
                ld      (dltc+1),hl
                ld      (dnec+1),hl
		ld	hl,CPCFP664_FLO_MUL
                ld      (dmulc+1),hl
		ld	hl,CPCFP664_FLO_REV_SUB
                ld      (dsubc+1),hl
		ld	hl,CPCFP664_FLO_EXP
                ld      (expc+1),hl
		ld	hl,CPCFP664_INT_2_FLO
                ld      (floatc+1),hl
		ld	hl,CPCFP664_FLO_BINFIX
                ld      (floorc+1),hl
		ld	hl,CPCFP664_BIN_2_FLO
                ld      (floorc2+1),hl
		ld	hl,CPCFP664_FLO_RND
                ld      (fprandc+1),hl
		ld	hl,CPCFP664_FLO_2_INT
                ld      (ifixc+1),hl
		ld	hl,CPCFP664_FLO_LOG10
                ld      (log10c+1),hl
		ld	hl,CPCFP664_FLO_LOG
                ld      (logc+1),hl
		ld	hl,CPCFP664_FLO_INV_SGN
                ld      (minusfac+1),hl
		ld	hl,CPCFP664_FLO_PI
                ld      (pic+1),hl
		ld	hl,CPCFP664_FLO_POW10
                ld      (pow10c+1),hl
		ld	hl,CPCFP664_FLO_POW
                ld      (powc+1),hl
		ld	hl,CPCFP664_FLO_SIN
                ld      (sinc+1),hl
		ld	hl,CPCFP664_FLO_SQRT
                ld      (sqrtc+1),hl
		ld	hl,CPCFP664_FLO_TAN
                ld      (tanc+1),hl
		ret
