build:
	docker build -t sqlwwx/silk-v3-decoder:latest .
publish:
	docker push sqlwwx/silk-v3-decoder

.PHONY: build publish
