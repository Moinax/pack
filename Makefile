PREFIX ?= ~/.local

install:
	install -Dm755 pack $(PREFIX)/bin/pack

uninstall:
	rm -f $(PREFIX)/bin/pack
