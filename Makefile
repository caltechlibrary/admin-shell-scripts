#
# Minimal Makefile to build documentation
#

#PREFIX = /usr/local
PREFIX = $(HOME)

ifneq ($(prefix),)
        PREFIX = $(prefix)
endif

BASH_SCRIPTS = $(shell ls -1 *.bash)

MAN_PAGES = $(shell for FNAME in $(BASH_SCRIPTS); do printf 'man/man1/%s.1 ' $$FNAME; done)

build: man/man1 $(MAN_PAGES)

man/man1:
	mkdir -p man/man1
	echo $(MAN_PAGES)

$(MAN_PAGES): $(BASH_SCRIPTS)

$(BASH_SCRIPTS): .FORCE
	bash $@ -h | pandoc --from markdown --to man -s >man/man1/$@.1

clean: .FORCE
	rm -fR man

install: build
	for FNAME in $(BASH_SCRIPTS); do cp -v $$FNAME $(PREFIX)/bin/; done
	for FNAME in $(MAN_PAGES); do cp -vp $$FNAME $(PREFIX)/; done

uninstall: .FORCE
	for FNAME in $(BASH_SCRIPTS); do if [ -f "$(PREFIX)/bin/$$FNAME" ]; then rm -v "$(PREFIX)/bin/$$FNAME"; fi; done
	for FNAME in $(MAN_PAGES); do if [ -f "$(PREFIX)/$$FNAME" ]; then rm -v "$(PREFIX)/$$FNAME"; fi; done

.FORCE:
