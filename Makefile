#
# Minimal Makefile to build documentation
#

PROJECT = admin-shell-scripts

PANDOC = $(shell which pandoc)

#PREFIX = /usr/local
PREFIX = $(HOME)

ifneq ($(prefix),)
		PREFIX = $(prefix)
endif

BASH_SCRIPTS = $(shell ls -1 *.bash)

MAN_PAGES = $(shell for FNAME in $(BASH_SCRIPTS); do printf 'man/man1/%s.1 ' $$FNAME; done)

DOCS = $(shell ls -1 *.bash | sed -E 's/.bash/.1.md/g')

build: man/man1 $(MAN_PAGES) about.md CITATION.cff

man/man1:
	mkdir -p man/man1
	echo $(MAN_PAGES)

$(MAN_PAGES): $(BASH_SCRIPTS)

$(DOCS): $(BASH_SCRIPTS)

website: .FORCE
	make -f website.mak

$(BASH_SCRIPTS): .FORCE
	bash $@ -h >$(basename $@).1.md
	bash $@ -h | $(PANDOC) --from markdown --to man -s >man/man1/$@.1

about.md: codemeta.json .FORCE
	cat codemeta.json | sed -E   's/"@context"/"at__context"/g;s/"@type"/"at __type"/g;s/"@id"/"at__id"/g' >_codemeta.json
	if [ -f $(PANDOC) ]; then echo "" | $(PANDOC) --metadata title="About $(PROJECT)" --metadata-file=_codemeta.json --template=codemeta-md.tmpl >about.md; fi

CITATION.cff: codemeta.json .FORCE
	cat codemeta.json | sed -E   's/"@context"/"at__context"/g;s/"@type"/"at __type"/g;s/"@id"/"at__id"/g' >_codemeta.json
	if [ -f $(PANDOC) ]; then echo "" | $(PANDOC) --metadata title="Cite $(PROJECT)" --metadata-file=_codemeta.json --template=codemeta-cff.tmpl >CITATION.cff; fi

clean: .FORCE
	rm -fR man
	make -f website.mak clean

install: build
	for FNAME in $(BASH_SCRIPTS); do cp -v $$FNAME $(PREFIX)/bin/; done
	for FNAME in $(MAN_PAGES); do cp -vp $$FNAME $(PREFIX)/man/man1/; done

uninstall: .FORCE
	for FNAME in $(BASH_SCRIPTS); do if [ -f "$(PREFIX)/bin/$$FNAME" ]; then rm -v "$(PREFIX)/bin/$$FNAME"; fi; done
	for FNAME in $(MAN_PAGES); do if [ -f "$(PREFIX)/man/man1/$$FNAME" ]; then rm -v "$(PREFIX)/$$FNAME"; fi; done

status:
	git status

save:
	@if [ "$(msg)" != "" ]; then git commit -am "$(msg)"; else git commit -am "Quick Save"; fi
	git push origin $(BRANCH)

refresh:
	git fetch origin
	git pull origin $(BRANCH)


.FORCE:
