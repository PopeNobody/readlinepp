## -*- text -*- ##
# Master Makefile for the GNU readline library.
# Copyright (C) 1994-2018 Free Software Foundation, Inc.

#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.

#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.

#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
everything:

RL_LIBRARY_VERSION = 8.0
RL_LIBRARY_NAME = readline

PACKAGE = readline
VERSION = 8.0

PACKAGE_BUGREPORT = bug-readline@gnu.org
PACKAGE_NAME = readline
PACKAGE_STRING = readline 8.0
PACKAGE_VERSION = 8.0

PACKAGE_TARNAME = readline

srcdir = .

top_srcdir = .
BUILD_DIR = /home/rfp/src/lbc/readline

INSTALL = /usr/bin/install -c
INSTALL_PROGRAM = ${INSTALL}
INSTALL_DATA = ${INSTALL} -m 644

RANLIB = ranlib
AR = ar
ARFLAGS = cr
RM = rm -f
CP = cp
MV = mv


SHELL = /bin/sh

prefix = /home/rfp
exec_prefix = ${prefix}

datarootdir = ${prefix}/share

bindir = ${exec_prefix}/bin
libdir = ${exec_prefix}/lib
mandir = ${datarootdir}/man
includedir = ${prefix}/include
datadir = ${datarootdir}
localedir = ${datarootdir}/locale
pkgconfigdir = ${libdir}/pkgconfig

infodir = ${datarootdir}/info

docdir = ${datarootdir}/doc/${PACKAGE_TARNAME}

man3dir = $(mandir)/man3

# Support an alternate destination root directory for package building
DESTDIR =

# Programs to make tags files.
ETAGS = etags
CTAGS = ctags 

CFLAGS = -g -O -fPIC
LOCAL_CFLAGS =  -DRL_LIBRARY_VERSION='"$(RL_LIBRARY_VERSION)"'
CPPFLAGS =  -MD -MF $@.d -DHAVE_CONFIG_H

DEFS = -DHAVE_CONFIG_H 
LOCAL_DEFS = 

TERMCAP_LIB = -ltermcap

# For libraries which include headers from other libraries.
INCLUDES = -I. -I$(srcdir)

XCCFLAGS = $(ASAN_CFLAGS) $(DEFS) $(LOCAL_DEFS) $(INCLUDES) $(CPPFLAGS)
CCFLAGS = $(XCCFLAGS) $(LOCAL_CFLAGS) $(CFLAGS)
CXXFLAGS = -Wno-write-strings $(CCFLAGS) -fpermissive -fPIC
CXX := g++
CC := false
export CC
#CC := /usr/stow/llvm-10a/bin/clang

# could add -Werror here
GCC_LINT_FLAGS = -ansi -Wall -Wshadow -Wpointer-arith -Wcast-qual \
		 -Wwrite-strings -Wstrict-prototypes \
		 -Wmissing-prototypes -Wno-implicit -pedantic
GCC_LINT_CFLAGS = $(XCCFLAGS) $(GCC_LINT_FLAGS) -g -O 

ASAN_XCFLAGS = -fsanitize=address -fno-omit-frame-pointer
ASAN_XLDFLAGS = -fsanitize=address

install_examples = install-examples

.cc.o:
	${RM} $@
	$(CXX) -c $(CXXFLAGS) $<

# The name of the main library target.
LIBRARY_NAME = libreadline++.a
STATIC_LIBS = libreadline++.a libhistory++.a

# The C code source files for this library.
CSOURCES = $(srcdir)/readline.cc $(srcdir)/funmap.cc $(srcdir)/keymaps.cc \
	   $(srcdir)/vi_mode.cc $(srcdir)/parens.cc $(srcdir)/rltty.cc \
	   $(srcdir)/complete.cc $(srcdir)/bind.cc $(srcdir)/isearch.cc \
	   $(srcdir)/display.cc $(srcdir)/signals.cc $(srcdir)/emacs_keymap.cc \
	   $(srcdir)/vi_keymap.cc $(srcdir)/util.cc $(srcdir)/kill.cc \
	   $(srcdir)/undo.cc $(srcdir)/macro.cc $(srcdir)/input.cc \
	   $(srcdir)/callback.cc $(srcdir)/terminal.cc $(srcdir)/xmalloc.cc $(srcdir)/xfree.cc \
	   $(srcdir)/history.cc $(srcdir)/histsearch.cc $(srcdir)/histexpand.cc \
	   $(srcdir)/histfile.cc $(srcdir)/nls.cc $(srcdir)/search.cc \
	   $(srcdir)/shell.cc $(srcdir)/savestring.cc $(srcdir)/tilde.cc \
	   $(srcdir)/text.cc $(srcdir)/misc.cc $(srcdir)/compat.cc \
	   $(srcdir)/mbutil.cc

# The header files for this library.
HSOURCES = $(srcdir)/readline.hh $(srcdir)/rldefs.hh $(srcdir)/chardefs.hh \
	   $(srcdir)/keymaps.hh $(srcdir)/history.hh $(srcdir)/histlib.hh \
	   $(srcdir)/posixstat.hh $(srcdir)/posixdir.hh $(srcdir)/posixjmp.hh \
	   $(srcdir)/tilde.hh $(srcdir)/rlconf.hh $(srcdir)/rltty.hh \
	   $(srcdir)/ansi_stdlib.hh $(srcdir)/tcap.hh $(srcdir)/rlstdc.hh \
	   $(srcdir)/xmalloc.hh $(srcdir)/rlprivate.hh $(srcdir)/rlshell.hh \
	   $(srcdir)/rltypedefs.hh $(srcdir)/rlmbutil.hh \
	   $(srcdir)/colors.hh $(srcdir)/parse-colors.hh

HISTOBJ = history.o histexpand.o histfile.o histsearch.o shell.o mbutil.o
TILDEOBJ = tilde.o
COLORSOBJ = colors.o parse-colors.o
OBJECTS = readline.o vi_mode.o funmap.o keymaps.o parens.o search.o \
	  rltty.o complete.o bind.o isearch.o display.o signals.o \
	  util.o kill.o undo.o macro.o input.o callback.o terminal.o \
	  text.o nls.o misc.o $(HISTOBJ) $(TILDEOBJ) $(COLORSOBJ) \
	  xmalloc.o xfree.o compat.o

# The texinfo files which document this library.
DOCSOURCE = doc/rlman.texinfo doc/rltech.texinfo doc/rluser.texinfo
DOCOBJECT = doc/readline.dvi
DOCSUPPORT = doc/Makefile
DOCUMENTATION = $(DOCSOURCE) $(DOCOBJECT) $(DOCSUPPORT)

CREATED_MAKEFILES = Makefile doc/Makefile examples/Makefile 
CREATED_CONFIGURE = config.status config.hh config.cache config.log \
		    stamp-config stamp-h readline++.pc
CREATED_TAGS = TAGS tags

INSTALLED_HEADERS = readline.hh chardefs.hh keymaps.hh history.hh tilde.hh \
		    rlstdc.hh rlconf.hh rltypedefs.hh

OTHER_DOCS = $(srcdir)/CHANGES $(srcdir)/INSTALL $(srcdir)/README
OTHER_INSTALLED_DOCS = CHANGES INSTALL README

##########################################################################
TARGETS = static
INSTALL_TARGETS = install-static

all: $(TARGETS)

everything: all examples

asan:
	${MAKE} ${MFLAGS} ASAN_CFLAGS='${ASAN_XCFLAGS}' ASAN_LDFLAGS='${ASAN_XLDFLAGS}' everything

static: $(STATIC_LIBS)

libreadline++.a: $(OBJECTS)
	$(RM) $@
	$(AR) $(ARFLAGS) $@ $(OBJECTS)
	-test -n "$(RANLIB)" && $(RANLIB) $@

libhistory++.a: $(HISTOBJ) xmalloc.o xfree.o
	$(RM) $@
	$(AR) $(ARFLAGS) $@ $(HISTOBJ) xmalloc.o xfree.o
	-test -n "$(RANLIB)" && $(RANLIB) $@

# Since tilde.cc is shared between readline and bash, make sure we compile
# it with the right flags when it's built as part of readline
tilde.o:	tilde.cc
	rm -f $@
	$(CXX) $(CCFLAGS) -DREADLINE_LIBRARY -c $(srcdir)/tilde.cc

readline: $(OBJECTS) readline.hh rldefs.hh chardefs.hh ./libreadline++.a
	$(CXX) $(CCFLAGS) -DREADLINE_LIBRARY -o $@ $(top_srcdir)/examples/rl.cc ./libreadline++.a ${TERMCAP_LIB}

lint:	force
	$(MAKE) $(MFLAGS) CCFLAGS='$(GCC_LINT_CFLAGS)' static

Makefile: config.status $(srcdir)/Makefile.in
	CONFIG_FILES=Makefile CONFIG_HEADERS= $(SHELL) ./config.status

$(filter-out Makefile, $(CREATED_MAKEFILES)): %: %.in config.status $(srcdir)/Makefile.in
	@for mf in $(CREATED_MAKEFILES); do \
		CONFIG_FILES=$$mf CONFIG_HEADERS= $(SHELL) ./config.status ; \
	done

config.status: configure
	$(SHELL) ./config.status --recheck

config.hh:	stamp-h

stamp-h: config.status $(srcdir)/config.hh.in
	CONFIG_FILES= CONFIG_HEADERS=config.hh ./config.status
	echo > $@

$(srcdir)/configure: $(srcdir)/configure.ac	## Comment-me-out in distribution
	cd $(srcdir) && autoconf	## Comment-me-out in distribution



documentation: force
	-test -d doc || mkdir doc
	-( cd doc && $(MAKE) $(MFLAGS) )

examples: all force
	-(cd examples && ${MAKE} ${MFLAGS} all )

force:

install:	$(INSTALL_TARGETS)

install-headers: installdirs ${INSTALLED_HEADERS}
	for f in ${INSTALLED_HEADERS}; do \
		$(INSTALL_DATA) $(srcdir)/$$f $(DESTDIR)$(includedir)/readline ; \
	done

uninstall-headers:
	-test -n "$(includedir)" && cd $(DESTDIR)$(includedir)/readline && \
		${RM} ${INSTALLED_HEADERS}

maybe-uninstall-headers: uninstall-headers

install-pc: installdirs
	-$(INSTALL_DATA) $(BUILD_DIR)/readline++.pc $(DESTDIR)$(pkgconfigdir)/readline++.pc

uninstall-pc:
	-test -n "$(pkgconfigdir)" && cd $(DESTDIR)$(pkgconfigdir) && \
		${RM} readline++.pc

maybe-uninstall-pc: uninstall-pc

install-static: installdirs $(STATIC_LIBS) install-headers install-doc ${install_examples} install-pc
	-$(MV) $(DESTDIR)$(libdir)/libreadline++.a $(DESTDIR)$(libdir)/libreadline++.old
	$(INSTALL_DATA) libreadline++.a $(DESTDIR)$(libdir)/libreadline++.a
	-test -n "$(RANLIB)" && $(RANLIB) $(DESTDIR)$(libdir)/libreadline++.a
	-$(MV) $(DESTDIR)$(libdir)/libhistory++.a $(DESTDIR)$(libdir)/libhistory++.old
	$(INSTALL_DATA) libhistory++.a $(DESTDIR)$(libdir)/libhistory++.a
	-test -n "$(RANLIB)" && $(RANLIB) $(DESTDIR)$(libdir)/libhistory++.a

installdirs: $(srcdir)/support/mkinstalldirs
	-$(SHELL) $(srcdir)/support/mkinstalldirs $(DESTDIR)$(includedir) \
		$(DESTDIR)$(includedir)/readline $(DESTDIR)$(libdir) \
		$(DESTDIR)$(infodir) $(DESTDIR)$(man3dir) $(DESTDIR)$(docdir) \
		$(DESTDIR)$(pkgconfigdir)

uninstall: uninstall-headers uninstall-doc uninstall-examples uninstall-pc
	-test -n "$(DESTDIR)$(libdir)" && cd $(DESTDIR)$(libdir) && \
		${RM} libreadline++.a libreadline++.old libhistory++.a libhistory++.old

install-examples: installdirs install-headers
	-( cd examples ; ${MAKE} ${MFLAGS} DESTDIR=${DESTDIR} install )
	
uninstall-examples: maybe-uninstall-headers
	-( cd examples; ${MAKE} ${MFLAGS} DESTDIR=${DESTDIR} uninstall )

install-doc:	installdirs
	$(INSTALL_DATA) $(OTHER_DOCS) $(DESTDIR)$(docdir)
	-( if test -d doc ; then \
		cd doc && \
		${MAKE} ${MFLAGS} infodir=$(infodir) DESTDIR=${DESTDIR} install; \
	  fi )

uninstall-doc:
	-( cd $(DESTDIR)$(docdir) && ${RM} ${OTHER_INSTALLED_DOCS} )
	-( if test -d doc ; then \
		cd doc && \
		${MAKE} ${MFLAGS} infodir=$(infodir) DESTDIR=${DESTDIR} uninstall; \
	  fi )

TAGS:	force
	-( cd $(srcdir) && $(ETAGS) $(CSOURCES) $(HSOURCES) )

tags:	force
	-( cd $(srcdir) && $(CTAGS) $(CSOURCES) $(HSOURCES) )

clean:	force
	$(RM) $(OBJECTS) $(STATIC_LIBS) $(patsubst %,%.d,$(OBJECTS))
	$(RM) readline readline.exe
	-( cd doc && $(MAKE) $(MFLAGS) $@ )
	-( cd examples && $(MAKE) $(MFLAGS) $@ )

mostlyclean: clean
	-( cd doc && $(MAKE) $(MFLAGS) $@ )
	-( cd examples && $(MAKE) $(MFLAGS) $@ )

distclean maintainer-clean: clean
	-( cd doc && $(MAKE) $(MFLAGS) $@ )
	-( cd examples && $(MAKE) $(MFLAGS) $@ )
	$(RM) Makefile
	$(RM) $(CREATED_CONFIGURE)
	$(RM) $(CREATED_TAGS)

readline++.pc:	config.status $(srcdir)/readline++.pc.in
	$(SHELL) config.status

info dvi html pdf ps:
	-( cd doc && $(MAKE) $(MFLAGS) $@ )

install-info:
install-dvi:
install-html:
install-pdf:
install-ps:
check:
installcheck:

dist:   force
	@echo Readline distributions are created using $(srcdir)/support/mkdist.
	@echo Here is a sample of the necessary commands:
	@echo bash $(srcdir)/support/mkdist -m $(srcdir)/MANIFEST -s $(srcdir) -r $(RL_LIBRARY_NAME) $(RL_LIBRARY_VERSION)
	@echo tar cf $(RL_LIBRARY_NAME)-${RL_LIBRARY_VERSION}.tar ${RL_LIBRARY_NAME}-$(RL_LIBRARY_VERSION)
	@echo gzip $(RL_LIBRARY_NAME)-$(RL_LIBRARY_VERSION).tar

# Tell versions [3.59,3.63) of GNU make not to export all variables.
# Otherwise a system limit (for SysV at least) may be exceeded.
.NOEXPORT:

# Dependencies
include /dev/null $(wildcard *.d)
