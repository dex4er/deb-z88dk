#
# Wahey, a messed up makefile for building libraries!
#
# $Id: Makefile,v 1.14 2008/03/05 20:35:48 dom Exp $

include ../Make.config

lz88: time z88_time

lpps: time pps_time

lzx: spectrum_time

time: gmtime.o localtime.o mktime.o

.c.o:
	zcc +test $(CFLAGS) $*.c

pps_time:
	cd sprinter ; $(MAKE) ; cd ..

z88_time:
	cd z88 ; $(MAKE) ; cd ..

spectrum_time:
	cd spectrum ; $(MAKE) ; cd ..

clean:
	$(RM) *.o* *.i *.sym *.map zcc_opt.def
	$(RM) zx81/*.o*
	$(RM) newbrain/*.o*
	$(RM) rcmx000/*.o*
	cd z88 ; $(MAKE) clean ; cd ..
	cd spectrum ; $(MAKE) clean ; cd ..
	cd sprinter ; $(MAKE) clean ; cd ..
