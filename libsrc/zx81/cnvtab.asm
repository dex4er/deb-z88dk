;
;	ZX81 Stdio
;
;	ASCII-ZX81 conversion Table
;	used by fgetc_cons and fputc_cons
;
;	Stefano Bodrato - Apr. 2000
;
;
;	$Id: cnvtab.asm,v 1.2 2007/12/19 18:13:43 stefano Exp $
;

	XLIB	zx81_cnvtab


.zx81_cnvtab
	defb	114	; cursor-left
	defb	8
        defb	115	; cursor-right
        defb	9
        defb	112	; cursor-up
        defb	11
        defb	113	; cursor-down
        defb	10
	defb	119	; Rubout
	defb	12
	defb	118	; Newline
	defb	13
	defb	11
	defb	'"'
	defb	12
	defb	'�'
	defb	13
	defb	'$'
	defb	14
	defb	':'
	defb	15
	defb	'?'
	defb	16
	defb	'('
	defb	17
	defb	')'
	defb	18
	defb	'>'
	defb	19
	defb	'<'
	defb	20
	defb	'='
	defb	21
	defb	'+'
	defb	22
	defb	'-'
	defb	23
	defb	'*'
	defb	24
	defb	'/'
	defb	25
	defb	';'
	defb	26
	defb	','
	defb	27
	defb	'.'
	defb	1
	defb	39 ;"'"
	defw	0

