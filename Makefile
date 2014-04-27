NAME=oma-welcome
VERSION=1.0.3

all:

install:
	mkdir -p $(DESTDIR)$(prefix)/$(bindir)
	mkdir -p $(DESTDIR)$(prefix)/$(sysconfdir)/skel/Desktop
	mkdir -p $(DESTDIR)$(prefix)/$(sharedir)/$(NAME)
	mkdir -p $(DESTDIR)$(prefix)/$(sharedir)/applications
	mkdir -p $(DESTDIR)$(prefix)/$(localedir)
	install -m 644 data/*.desktop $(DESTDIR)$(prefix)/$(sysconfdir)/skel/Desktop
	install -m 644 data/*.desktop $(DESTDIR)$(prefix)/$(sharedir)/applications
	install -m 755 usr/bin/* $(DESTDIR)$(prefix)/$(bindir)
	install -m 644 usr/share/om-welcome/* $(DESTDIR)$(prefix)/$(sharedir)/$(NAME)
	install -m 644 usr/share/locale/* $(DESTDIR)$(prefix)/$(localedir)

dist:
	git archive --format=tar --prefix=$(NAME)-$(VERSION)/ HEAD | xz -2vec -T0 > $(NAME)-$(VERSION).tar.xz;
	$(info $(NAME)-$(VERSION).tar.xz is ready)

