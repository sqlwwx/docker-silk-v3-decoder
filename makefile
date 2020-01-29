VERSION ?= $(shell git describe --tags `git rev-list --tags --max-count=1` | sed -e 's/^v//')
RELEASES = patch minor major

build:
	docker build -t sqlwwx/silk-v3-decoder:$(VERSION) -t sqlwwx/silk-v3-decoder:latest .
	docker build -f Dockerfile.alinode -t sqlwwx/silk-v3-decoder-alinode:$(VERSION) -t sqlwwx/silk-v3-decoder-alinode:latest .
publish:
	docker push sqlwwx/silk-v3-decoder:$(VERSION)
	docker push sqlwwx/silk-v3-decoder
	docker push sqlwwx/silk-v3-decoder-alinode:$(VERSION)
	docker push sqlwwx/silk-v3-decoder-alinode:latest

all: build publish

.PHONY: $(RELEASES)
$(RELEASES):
	$(PWD)/node_modules/.bin/standard-version --release-as $@
	git push --follow-tags origin master

.PHONY: build publish
