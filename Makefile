#
#
#	The impromptu compilation makefile for z88dk
#
#	$Id: Makefile,v 1.32 2008/03/01 15:06:51 dom Exp $
#

# ---> Configurable parameters are below his point

prefix = /usr/local
prefix_share = $(prefix)/share

# The default machine, the lib/config/DEFAULT.cfg file is copied to zcc.cfg
DEFAULT = z88

# --> End of Configurable Options

all: setup appmake copt zcpp sccz80 z80asm zcc config

# setenv CC "dcc -unixrc -mC -mD"
# make -e amiga
amiga:  clean-bins
	# Now build the Amiga binaries
	echo '#define PREFIX "zcc:"' > src/config.h
	echo '#define AMIGA 1' >> src/config.h
	mkdir -p z88dk/bin 
	$(MAKE) -C src/appmake 
	$(MAKE) -C src/appmake install PREFIX=`pwd`/z88dk
	$(MAKE) -C src/appmake clean
	$(MAKE) -C src/copt 
	$(MAKE) -C src/copt install PREFIX=`pwd`/z88dk
	$(MAKE) -C src/copt clean
	$(MAKE) -C src/cpp 
	$(MAKE) -C src/cpp install PREFIX=`pwd`/z88dk
	$(MAKE) -C src/cpp clean
	$(MAKE) -C src/sccz80 
	$(MAKE) -C src/sccz80 install PREFIX=`pwd`/z88dk
	$(MAKE) -C src/sccz80 clean
	$(MAKE) -C src/z80asm 
	$(MAKE) -C src/z80asm install PREFIX=`pwd`/z88dk
	$(MAKE) -C src/z80asm clean
	$(MAKE) -C src/zcc  
	$(MAKE) -C src/zcc install PREFIX=`pwd`/z88dk
	$(MAKE) -C src/zcc clean
	$(MAKE) -C libsrc clean
	./config.sh zcc: z88
	cp -R  libsrc/ include/ lib/ examples/ doc/ support/ src/ z88dk/
	cp amiga.patch EXTENSIONS LICENSE Makefile amigabuild.sh z88dk/
	cp README.1st z88dk/
	cd z88dk ; patch -p0 < amiga.patch


setup:
	echo '#define PREFIX "${prefix}$"/lib/z88dk"' > src/config.h
	echo '#define UNIX 1' >> src/config.h

appmake:
	$(MAKE) -C src/appmake
	$(MAKE) -C src/appmake PREFIX=`pwd` install

copt:
	$(MAKE) -C src/copt
	$(MAKE) -C src/copt PREFIX=`pwd` install

zcpp:
	$(MAKE) -C src/cpp
	$(MAKE) -C src/cpp PREFIX=`pwd` install

sccz80:
	$(MAKE) -C src/sccz80
	$(MAKE) -C src/sccz80 PREFIX=`pwd` install

z80asm:
	echo 'Configure z80asm for ENDIAN status!!'
	$(MAKE) -C src/z80asm
	$(MAKE) -C src/z80asm PREFIX=`pwd` install

zcc:
	$(MAKE) -C src/zcc
	$(MAKE) -C src/zcc PREFIX=`pwd` install

config:
	./config.sh `pwd`/ $(DEFAULT)

libs:
	cd libsrc ; $(MAKE)
	cd libsrc ; $(MAKE) install

install-libs:
	mkdir -p $(prefix)/lib/z88dk/lib/clibs
	cp -R lib/clibs/* $(prefix)/lib/z88dk/lib/clibs/
	find $(prefix)/lib/z88dk/lib/clibs -type f | xargs chmod 644


install:
	mkdir -p -m 755 $(DESTDIR)/$(prefix)/bin $(DESTDIR)/$(prefix_share)/z88dk
	mkdir -p -m 755 $(DESTDIR)/$(prefix_share)/z88dk/lib
	mkdir -p -m 755 $(DESTDIR)/$(prefix_share)/z88dk/lib/clibs 
	mkdir -p -m 755 $(DESTDIR)/$(prefix_share)/z88dk/lib/config
	cd src/appmake ; $(MAKE) PREFIX=$(DESTDIR)/$(prefix) install
	cd src/copt ; $(MAKE) PREFIX=$(DESTDIR)/$(prefix) install
	cd src/cpp ; $(MAKE) PREFIX=$(DESTDIR)/$(prefix) install
	cd src/sccz80 ; $(MAKE) PREFIX=$(DESTDIR)/$(prefix) install
	cd src/z80asm ; $(MAKE) PREFIX=$(DESTDIR)/$(prefix) install
	cd src/zcc ; $(MAKE) PREFIX=$(DESTDIR)/$(prefix) install
	./config.sh $(prefix_share)/z88dk/ $(DEFAULT)
	cp -R -p include $(DESTDIR)/$(prefix_share)/z88dk
	cp -R -p lib $(DESTDIR)/$(prefix_share)/z88dk
	find $(DESTDIR)/$(prefix_share)/z88dk -type f -exec chmod 644 {} \;
	find $(DESTDIR)/$(prefix_share)/z88dk -type d -exec chmod 755 {} \;

clean: clean-bins
	cd libsrc ; $(MAKE) clean
	cd lib/config ; $(RM) *.cfg
	cd lib/clibs ; $(RM) *.lib
	find . -name "*.o" -type f -exec rm -f {} \;

clean-bins:
	cd src/appmake ; $(MAKE) clean
	cd src/copt ; $(MAKE) clean
	cd src/cpp ; $(MAKE) clean
	cd src/sccz80 ; $(MAKE) clean
	cd src/z80asm ; $(MAKE) clean
	cd src/zcc ; $(MAKE) clean
