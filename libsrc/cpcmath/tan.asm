;
;	CPC Maths Routines
;
;	August 2003 **_|warp6|_** <kbaccam /at/ free.fr>
;
;	$Id: tan.asm,v 1.2 2007/07/21 21:28:22 dom Exp $
;

		INCLUDE		"#cpcfirm.def"
		INCLUDE		"#cpcfp.def"

		XLIB		tan
		XDEF		tanc

		LIB		get_para

.tan	call	get_para
        call    firmware
.tanc	defw	CPCFP_FLO_TAN
		ret
