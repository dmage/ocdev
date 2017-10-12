OCDEV=ocdev

all: test

test: check-docs

.PHONY: check-docs
check-docs:
	@doc=`$(OCDEV) help $(COMMAND) | grep "^  "`; \
	commands=`$(OCDEV) commands $(COMMAND)`; \
	for cmd in $$commands; do \
		echo "$$doc" | grep " $$cmd " >/dev/null && echo $(COMMAND) $$cmd -- ok || echo $(COMMAND) $$cmd -- NO DOCUMENTATION; \
		$(MAKE) check-docs COMMAND="$(COMMAND) $$cmd"; \
	done; \
	for cmd in `echo "$$doc" | cut -d " " -f 3`; do \
		echo "$$commands" | sed -e 's/^/ /;s/$$/ /' | grep " $$cmd " >/dev/null || echo $(COMMAND) $$cmd -- NOT IMEPLEMENTED; \
	done
