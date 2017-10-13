OCDEV=ocdev

all: test

test: check-docs

.PHONY: check-docs
check-docs:
	./scripts/check-docs.sh
