OCDEV=ocdev

all: test

test check: check-docs

.PHONY: check-docs
check-docs:
	./scripts/check-docs.sh
