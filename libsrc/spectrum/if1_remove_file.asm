;
;	ZX IF1 & Microdrive functions
;
;	remove a given file in the given drive
;
;	int if1_remove (int drive, char *filename);
;	
;	$Id: if1_remove_file.asm,v 1.2 2006/05/23 21:47:25 stefano Exp $
;


		XLIB 	if1_remove_file

		LIB	if1_setname
		LIB	if1_rommap

		XREF	ERASEM


; parameters and variables
filename:	defs	10

if1_remove_file:

		rst	8
		defb 	31h		; Create Interface 1 system vars if required

		pop	af
		pop	de	;filename
		pop	bc	;driveno
		push	bc
		push	de
		push	af

		ld	a,c
		ld	($5cd6),a
			
		push	de
		ld	hl,filename	; filename location
		push	hl
		call	if1_setname
		ld	($5cda),hl	; length
		pop	de
		ld	($5cdc),hl	; pointer to filename

		call	if1_rommap
		call	ERASEM
		call	1		; unpage
		ei
		ld	hl,0
		ret

