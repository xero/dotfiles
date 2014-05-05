.PHONY: all clean install uninstall
DOTVIM=$(HOME)/.vim
FILES=plugin/colorizer.vim autoload/colorizer.vim

all:
	@echo "Available phony targets: install, uninstall"

install:
	for f in $(FILES); do install -m644 $$f $(DOTVIM)/$$f; done

uninstall:
	rm -f $(FILES)
