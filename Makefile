#
#  Utility makefile for people working with sift.
#
#  The targets are intended to be useful for people who are using
# the remote repository - but it also contains other useful targets.
#
# Steve
# --
# http://www.steve.org.uk/
#

#
#  Only used to build distribution tarballs.
#
DIST_PREFIX = ${TMP}
VERSION     = 0.2
BASE        = sift


#
#  Installation prefix, useful for the Debian package.
#
prefix=


nop:
	@echo "Valid targets are (alphabetically) :"
	@echo " "
	@echo " clean         = Remove bogus files and any local output."
	@echo " diff          = See the local changes."
	@echo " update        = Update from the remote repository."
	@echo " "


#
#  Delete all temporary files, recursively.
#
clean:
	@find . -name '.*~' -exec rm \{\} \;
	@find . -name '.#*' -exec rm \{\} \;
	@find . -name '*~' -exec rm \{\} \;
	@find . -name '*.bak' -exec rm \{\} \;
	@find . -name '*.tmp' -exec rm \{\} \;
	@if [ -d ./debian/sift ]; then rm -rf ./debian/sift ]; fi
	@if [ -e build-stamp ]; then rm -f build-stamp; fi
	@if [ -e sift.1 ]; then rm -f sift.1 ; fi



#
#  Show what has been changed in the local copy vs. the remote repository.
#
diff:
	hg diff


#
#  Install to /usr/bin/
#
install:
	mkdir -p ${prefix}/usr/bin
	cp ./bin/sift ${prefix}/usr/bin/


#
#  Make a new release tarball, and make a GPG signature.
#
release: tidy clean
	rm -rf $(DIST_PREFIX)/$(BASE)-$(VERSION)
	rm -f $(DIST_PREFIX)/$(BASE)-$(VERSION).tar.gz
	cp -R . $(DIST_PREFIX)/$(BASE)-$(VERSION)
	perl -pi.bak -e "s/UNRELEASED/$(VERSION)/g" $(DIST_PREFIX)/$(BASE)-$(VERSION)/bin/sift
	rm  $(DIST_PREFIX)/$(BASE)-$(VERSION)/bin/*.bak
	find  $(DIST_PREFIX)/$(BASE)-$(VERSION)/ -name "*steve*" -print | xargs rm -rf
	rm -rf $(DIST_PREFIX)/$(BASE)-$(VERSION)/debian
	cd $(DIST_PREFIX) && tar -cvf $(DIST_PREFIX)/$(BASE)-$(VERSION).tar $(BASE)-$(VERSION)/
	gzip $(DIST_PREFIX)/$(BASE)-$(VERSION).tar
	mv $(DIST_PREFIX)/$(BASE)-$(VERSION).tar.gz .
	rm -rf $(DIST_PREFIX)/$(BASE)-$(VERSION)
	gpg --armour --detach-sign $(BASE)-$(VERSION).tar.gz


#
#  Tidy the code
#
tidy:
	if [ -x ~/bin/perltidy ]; then \
		~/bin/perltidy ./bin/sift ; \
	fi



#
#  Update the local copy from the remote repository.
#
update:
	hg pull --update

