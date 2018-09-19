build:
	docker build -t sqlwwx/silk2mp3:latest .
publish:
	docker push sqlwwx/silk2mp3

.PHONY: build publish
