#
# Wahey, a messed up makefile for building libraries!
# $Id: Makefile,v 1.21 2008/03/05 20:35:46 dom Exp $
#

include ../Make.config

CFILES = \
	acos.c \
	asin.c \
	atan2.c \
	atof.c \
	cosh.c \
	ftoa.c \
	ftoe.c \
	pow.c \
	sinh.c \
	tanh.c 

AFILES  = $(CFILES:.c=.asm)
OBJECTS = $(CFILES:.c=.o)

all: genmath

genmath: $(OBJECTS)
	$(LIBLINKER) -x../$(OUTPUT_DIRECTORY)/gen_math @genlist

.c.o:
	zcc +test $(CFLAGS) $*.c

clean:
	$(RM) *.o* *.sym *.map *.err zcc_opt.def *.i $(AFILES)

