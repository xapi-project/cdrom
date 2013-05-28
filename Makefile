OBUILDOPTS=--debug+
#CONFOPTS=--enable-library-bytecode --enable-executable-bytecode
PKGNAME=cdrom

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
	ocamlfind install $(PKGNAME) dist/build/lib-$(PKGNAME)/*.{a,so,cma,cmxa,cmi} lib/META lib/$(PKGNAME).mli $(INSTALL_ARGS)

clean:
	obuild clean

uninstall:
	ocamlfind remove $(PKGNAME)
