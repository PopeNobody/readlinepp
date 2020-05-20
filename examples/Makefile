#
# This is the Makefile for the readline examples subdirectory.
#
# Copyright (C) 1994,2008,2009 Free Software Foundation, Inc.

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

RL_LIBRARY_VERSION = 8.0

SHELL = /bin/sh
RM = rm -f

prefix = /home/rfp/src/bittrex
exec_prefix = ${prefix}

datarootdir = ${prefix}/share

bindir = ${exec_prefix}/bin
srcdir = .
datadir = ${datarootdir}

top_srcdir = ..
#BUILD_DIR = .
BUILD_DIR = /home/rfp/src/bittrex/cypsh/readline
installdir = $(datadir)/readline

INSTALL = /usr/bin/install -c
INSTALL_PROGRAM = ${INSTALL}
INSTALL_DATA = ${INSTALL} -m 644

EXEEXT = 
OBJEXT = o

# Support an alternate destination root directory for package building
DESTDIR =

DEFS = -DHAVE_CONFIG_H
CC = gcc
CFLAGS = -g -O
LOCAL_CFLAGS =  -DREADLINE_LIBRARY -DRL_LIBRARY_VERSION='"$(RL_LIBRARY_VERSION)"'
CPPFLAGS =  -MD -MF $@.d 

INCLUDES = -I$(srcdir) -I$(top_srcdir) -I..

CCFLAGS  = $(ASAN_CFLAGS) $(DEFS) $(LOCAL_CFLAGS) $(INCLUDES) $(CPPFLAGS) \
	$(CFLAGS)
CXXFLAGS = $(CCFLAGS)

LDFLAGS = -g -L..  $(ASAN_LDFLAGS)

ASAN_XCFLAGS = -fsanitize=address -fno-omit-frame-pointer
ASAN_XLDFLAGS = -fsanitize=address

READLINE_LIB = ../libreadline++.a
HISTORY_LIB = ../libhistory++.a

TERMCAP_LIB = -ltermcap

.cc.o:
	${RM} $@
	$(CXX) $(CXXFLAGS) -c $<

SOURCES = excallback.cc fileman.cc histexamp.cc manexamp.cc rl-fgets.cc rl.cc \
		rlbasic.cc rlcat.cc rlevent.cc rlptytest.cc rltest.cc rlversion.cc \
		 rl-callbacktest.cc hist_erasedups.cc hist_purgecmd.cc \
		rlkeymaps.cc

EXECUTABLES = fileman$(EXEEXT) rltest$(EXEEXT) rl$(EXEEXT) rlcat$(EXEEXT) \
		rlevent$(EXEEXT) rlversion$(EXEEXT) histexamp$(EXEEXT) \
		rl-callbacktest$(EXEEXT) rlbasic$(EXEEXT) \
		hist_erasedups$(EXEEXT) hist_purgecmd$(EXEEXT) \
		rlkeymaps$(EXEEXT)

OBJECTS = fileman.o rltest.o rl.o rlevent.o rlcat.o rlversion.o histexamp.o \
	  rl-callbacktest.o rlbasic.o hist_erasedups.o hist_purgecmd.o \
	  rlkeymaps.o

OTHEREXE = rlptytest$(EXEEXT)
OTHEROBJ = rlptytest.o

all: $(EXECUTABLES)
everything: all
install: 


asan:
	${MAKE} ${MFLAGS} ASAN_CFLAGS='${ASAN_XCFLAGS}' ASAN_LDFLAGS='${ASAN_XLDFLAGS}' all

check:	rlversion$(EXEEXT)
	@echo Readline version: `rlversion$(EXEEXT)`

installdirs:
	-$(SHELL) $(top_srcdir)/support/mkdirs $(DESTDIR)$(installdir)

install:	installdirs
	@for f in $(SOURCES); do \
		$(RM) $(DESTDIR)$(installdir)/$$f ; \
		$(INSTALL_DATA) $(srcdir)/$$f $(DESTDIR)$(installdir) ; \
	done

uninstall:
	@for f in $(SOURCES); do \
		$(RM) $(DESTDIR)$(installdir)/$$f ; \
	done
	-rmdir $(DESTDIR)$(installdir)

rl$(EXEEXT): rl.o $(READLINE_LIB)
	$(CXX) $(LDFLAGS) -o $@ rl.o $(READLINE_LIB) $(TERMCAP_LIB)

rlbasic$(EXEEXT): rlbasic.o $(READLINE_LIB)
	$(CXX) $(LDFLAGS) -o $@ rlbasic.o $(READLINE_LIB) $(TERMCAP_LIB)

rlcat$(EXEEXT): rlcat.o $(READLINE_LIB)
	$(CXX) $(LDFLAGS) -o $@ rlcat.o $(READLINE_LIB) $(TERMCAP_LIB)

rlevent$(EXEEXT): rlevent.o $(READLINE_LIB)
	$(CXX) $(LDFLAGS) -o $@ rlevent.o $(READLINE_LIB) $(TERMCAP_LIB)

rlkeymaps$(EXEEXT): rlkeymaps.o $(READLINE_LIB)
	$(CXX) $(LDFLAGS) -o $@ rlkeymaps.o $(READLINE_LIB) $(TERMCAP_LIB)

fileman$(EXEEXT): fileman.o $(READLINE_LIB)
	$(CXX) $(LDFLAGS) -o $@ fileman.o $(READLINE_LIB) $(TERMCAP_LIB)

rltest$(EXEEXT): rltest.o $(READLINE_LIB)
	$(CXX) $(LDFLAGS) -o $@ rltest.o $(READLINE_LIB) $(TERMCAP_LIB)

rl-callbacktest$(EXEEXT): rl-callbacktest.o $(READLINE_LIB)
	$(CXX) $(LDFLAGS) -o $@ rl-callbacktest.o $(READLINE_LIB) $(TERMCAP_LIB)

rlptytest$(EXEEXT): rlptytest.o $(READLINE_LIB)
	$(CXX) $(LDFLAGS) -o $@ rlptytest.o $(READLINE_LIB) $(TERMCAP_LIB) $(LIBUTIL)

rlversion$(EXEEXT): rlversion.o $(READLINE_LIB)
	$(CXX) $(LDFLAGS) -o $@ rlversion.o $(READLINE_LIB) $(TERMCAP_LIB)

histexamp$(EXEEXT): histexamp.o $(HISTORY_LIB)
	$(CXX) $(LDFLAGS) -o $@ histexamp.o -lhistory++ $(TERMCAP_LIB)

hist_erasedups$(EXEEXT): hist_erasedups.o $(HISTORY_LIB)
	$(CXX) $(LDFLAGS) -o $@ hist_erasedups.o -lhistory++ $(TERMCAP_LIB)

hist_purgecmd$(EXEEXT): hist_purgecmd.o $(HISTORY_LIB)
	$(CXX) $(LDFLAGS) -o $@ hist_purgecmd.o -lhistory++ $(TERMCAP_LIB)

clean mostlyclean:
	$(RM) $(OBJECTS) $(OTHEROBJ)
	$(RM) $(EXECUTABLES) $(OTHEREXE) *.exe

distclean maintainer-clean: clean
	$(RM) Makefile

Makefile: Makefile.in ../config.status
	make -C .. examples/$@

include /dev/null $(wildcard *.d)
