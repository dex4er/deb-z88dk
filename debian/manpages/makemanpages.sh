#!/bin/bash
# Krystian W³osek <tygrys@waw.pdi.net>

export LANG=C

DOCS="z88dk zcc appmake copt sccz80 z80asm zcpp"
EXT="1.txt"
MANEXT="1"

for i in $DOCS; do
	if [ -e $i.$EXT ]; then
		echo "processing $i"
		txt2man -t $i -s 1 -v "z88 Development Kit" $i.$EXT > $i.$MANEXT
	fi
done
