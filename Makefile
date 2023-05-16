BINDIR ?= /usr/local/bin
EXE=subtree

install: $(EXE)
	install -d $(DESTDIR)$(BINDIR)
	install $(EXE) $(DESTDIR)$(BINDIR)

uninstall:
	rm -f $(addprefix $(DESTDIR)$(BINDIR)/, $(notdir $(EXE)))
