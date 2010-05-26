PROJECT = sxmloc
VERSION = 0.1

###
# distribution archive settings
#
DISTNAME = $(PROJECT)-$(VERSION)

####
# installation settings
#
PREFIX = /usr/local

BINDIR = $(PREFIX)/bin
SHAREDIR = $(PREFIX)/share
MYBINDIR = $(BINDIR)
MYSHAREDIR = $(SHAREDIR)/sxmloc

INSTALL = install
INSTALL_DIR = install -d
INSTALL_BIN = $(INSTALL) -m0755
INSTALL_NORMAL = $(INSTALL) -m0644

UNINSTALL = rm -f

ADJUST_HOME = sed 's:SXMLOC_HOME=.*:SXMLOC_HOME=$(MYSHAREDIR):'

####
# common utilities
#
MKDIR = mkdir
CP = cp
TARGZ = tar -czf
RM = rm -Rf


####
# rules
#

# by default, run the demo
all: demo

# run the demo
demo:
	$(MAKE) -C sample

# install to $(DESTDIR)$(PREFIX)
install:
	$(INSTALL_DIR) $(DESTDIR)$(MYBINDIR)
	for i in sxmloc-xml2pot sxmloc-translate; do \
		$(ADJUST_HOME) $$i | $(INSTALL_BIN) /dev/stdin $(DESTDIR)$(MYBINDIR)/$$i; \
	done
	$(INSTALL_DIR) $(DESTDIR)$(MYSHAREDIR)
	$(INSTALL_BIN) msgexec-po2xml $(DESTDIR)$(MYSHAREDIR)
	$(INSTALL_NORMAL) extract.xsl $(DESTDIR)$(MYSHAREDIR)

# uninstall from $(PREFIX)
uninstall:
	$(UNINSTALL) $(MYBINDIR)/sxmloc-xml2pot
	$(UNINSTALL) $(MYBINDIR)/sxmloc-translate
	$(UNINSTALL) $(MYSHAREDIR)/msgexec-po2xml
	$(UNINSTALL) $(MYSHAREDIR)/extract.xsl

# create distribution archive
dist:
	$(MKDIR) $(DISTNAME)
	$(CP) Makefile $(DISTNAME)
	$(CP) sxmloc-xml2pot sxmloc-translate $(DISTNAME)
	$(CP) extract.xsl sxmloc-0.1.dtd msgexec-po2xml $(DISTNAME)
	$(MKDIR) $(DISTNAME)/sample
	$(CP) sample/Makefile sample/cz.po sample/sample.xml $(DISTNAME)/sample
	$(TARGZ) $(DISTNAME).tar.gz $(DISTNAME)
	$(RM) $(DISTNAME)

# remove intermediary files
clean:
	$(MAKE) -C sample clean
