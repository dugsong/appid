
include_HEADERS = appid.h

lib_LTLIBRARIES = libappid.la

libappid_la_SOURCES = appid_list.c appid_hexdump.c appid.c

dist: appid_apps-$(VERSION).tar.gz

.PHONY: appid_apps-$(VERSION).tar.gz

appid_apps-$(VERSION).tar.gz:
	tar zcf $@ apps

if PYTHON
# XXX - some hackery here
noinst_SCRIPTS = python-build

appid.rl appid.h appid_list.c: appid.h.tmpl appid_list.c.tmpl appid.rl.tmpl
	$(PYTHON) gencode.py

pyappid.c: appid.pyx
	pyrexc -o $@ appid.pyx

python-build: pyappid.c
	$(PYTHON) setup.py build
	touch python-build

python-clean:
	rm -rf *build

clean: python-clean

distclean: clean

python-install:
	$(PYTHON) setup.py install --prefix=$(DESTDIR)$(prefix)

install-exec-local: python-install

endif

if RAGEL
appid.c: appid.rl
	$(RAGEL) appid.rl | $(RLGEN_CD) -G2 -o $@
endif

genclean: distclean
	rm -f appid.h appid.c appid_list.c appid.rl

EXTRA_DIST =	appid.h.tmpl appid.h appid.rl.tmpl appid.rl \
		appid_list.c.tmpl appid.pyx pyappid.c setup.py \
		HACKING LICENSE autogen.sh gencode.py stpy.py template

DISTCLEANFILES = *~ apps/*~
