#
# Wahey, a messed up makefile for building libraries!
#
# $Id: Makefile,v 1.5 2008/03/05 20:35:46 dom Exp $

include ../../Make.config

CFILES = \
	_putoffset.c \
	bdos.c \
	close.c \
	creat.c \
	getfcb.c \
	open.c \
	open_z88.c \
	parsefcb.c \
	read.c \
	readbyte.c \
	remove.c \
	setfcb.c \
	write.c \
	writebyte.c 

AFILES  = $(CFILES:.c=.asm)
OBJECTS = $(CFILES:.c=.o)

z88_fcntl: $(OBJECTS)

.c.o:
	zcc +cpm $(CFLAGS) $*.c

clean:
	$(RM) *.sym *.map zcc_opt.def *.o* *~ *.i $(AFILES)
