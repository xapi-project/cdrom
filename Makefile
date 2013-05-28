OBUILDOPTS=--debug+
#CONFOPTS=--enable-library-bytecode --enable-executable-bytecode
PKGNAME=cdrom

SUFFIXES:=cdrom.a cdrom.cmi cdrom.cmx cdrom.o dllstubs_cdrom.so \
       cdrom.cma  cdrom.cmo  cdrom.cmxa  cdrom_stubs.c.o  libstubs_cdrom.a
FILES:=$(addprefix dist/build/lib-$(PKGNAME)/,$(SUFFIXES))

ifneq "$(DESTDIR)" ""
INSTALL_ARGS := -destdir $(DESTDIR)
endif

.PHONY: configure build install clean uninstall

all: build

configure:
	obuild $(OBUILDOPTS) configure $(CONFOPTS)

build: configure
	obuild $(OBUILDOPTS) build

install: build
	ocamlfind remove $(PKGNAME)
	ocamlfind install $(PKGNAME) $(FILES) lib/META lib/$(PKGNAME).mli $(INSTALL_ARGS)

clean:
	obuild clean

uninstall:
	ocamlfind remove $(PKGNAME)
