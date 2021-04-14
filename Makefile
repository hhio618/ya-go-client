

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
	cp -r src/* target/
	cp -r target/* pkg/
	rm -rf pkg/*.jar

clean:
	find target \! -name 'openapi-generator-cli.jar' -delete
	rm m.*

.PHONY: all

