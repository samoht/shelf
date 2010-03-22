-include Makefile.config

.PHONY: all
all:
	$(MAKE) -C lib/

.PHONY: test
test: all
	$(MAKE) -C lib/
	$(MAKE) -C lib_test/ run

.PHONY: install
install: all
	$(SUDO) $(MAKE) -C lib/ libinstall

.PHONY: uninstall
uninstall:
	$(SUDO) $(MAKE) -C lib/ libuninstall

.PHONY: reinstall
reinstall:
	$(MAKE) uninstall
	$(MAKE) install

.PHONY: clean
clean:
	$(MAKE) -C lib/ clean
