

all:
	echo help


setup: m.setup m.patch

m.setup:
	./build-scripts/setup-target.sh
	./build-scripts/gen-all.sh
	touch m.setup

m.patch: m.setup
	./build-scripts/apply-patches.sh
	touch m.patch

m.build: m.patch
	cp -r src/* pkg/

clean:
	rm -rf src/*
	rm -rf pkg/*
	rm -rf m.*
	rm -rf go.*
	find target/* ! -name 'openapi-generator-cli.jar' -delete


.PHONY: all

