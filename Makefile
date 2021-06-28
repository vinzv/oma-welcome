NAME=sidu-welcome
VERSION=2.1.3
TRANSLATIONS=de en fr id it pt_BR pt_PT tr
bindir=/usr/bin
sysconfdir=/etc
sharedir=/usr/share
localedir=$(sharedir)/locale

all:

messages: usr/share/sidu-welcome/translation
	xgettext -d sidu-welcome -o usr/share/sidu-welcome/sidu-welcome.pot -L Shell --from-code utf-8 usr/share/sidu-welcome/translation
	for i in $(TRANSLATIONS); do \
		msgmerge -U po/$$i.po usr/share/sidu-welcome/sidu-welcome.pot; \
	done

install: messages
	mkdir -p $(DESTDIR)$(prefix)/$(bindir)
	mkdir -p $(DESTDIR)$(prefix)/$(sysconfdir)/xdg/autostart
	mkdir -p $(DESTDIR)$(prefix)/$(sharedir)/$(NAME)
	mkdir -p $(DESTDIR)$(prefix)/$(sharedir)/applications
	mkdir -p $(DESTDIR)$(prefix)/$(localedir)
	install -m 644 sidu-welcome.desktop $(DESTDIR)$(prefix)/$(sysconfdir)/xdg/autostart
	install -m 644 etc/skel/sidu-welcome.desktop $(DESTDIR)$(prefix)/$(sharedir)/applications
	install -m 755 usr/bin/* $(DESTDIR)$(prefix)/$(bindir)
	cp -avx usr/share/$(NAME)/* $(DESTDIR)$(prefix)/$(sharedir)/$(NAME)
	chmod -R 755 $(DESTDIR)$(prefix)/$(sharedir)/$(NAME)
	@for l in $(TRANSLATIONS); do \
	mkdir -p  $(DESTDIR)$(prefix)/$(localedir)/$$l/LC_MESSAGES; \
	msgcat po/$$l.po | msgfmt -o $(DESTDIR)$(prefix)$(localedir)/$$l/LC_MESSAGES/sidu-welcome.mo - ; \
	done

dist:
	git archive --format=tar --prefix=$(NAME)-$(VERSION)/ HEAD | xz -2vec -T0 > $(NAME)-$(VERSION).tar.xz;
	$(info $(NAME)-$(VERSION).tar.xz is ready)
