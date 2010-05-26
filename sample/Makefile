
BASEDIR = ../

all: sample-cz.xml

.PHONY: all clean po

po: cz.po

sample.pot: sample.xml
	$(BASEDIR)sxmloc-xml2pot <$< >$@

sample-cz.xml: sample.xml cz.po
	$(BASEDIR)sxmloc-translate cz.po sample.xml >$@

cz.po: sample.pot
	if [ -f "$@" ]; then \
		msgmerge --update $@ $<; \
	else \
		msginit -i $< -o $@; \
	fi

clean:
	rm -f sample.pot sample-cz.xml
