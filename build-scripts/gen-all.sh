#! /bin/bash 

expand_path() {
	local curdir

	curdir="$(pwd)"
	cd $1
	pwd
	cd "$curdir"
}

BUILDDIR=$(expand_path target)

echo builddir $BUILDDIR
test -d "$BUILDDIR" || exit 1

gen() {
	local NAME=$1
	local VERSION=$2
	local PROJECT_NAME=ya-$NAME
	local PKG_NAME=ya_$NAME
	
	cd "$BUILDDIR"
	
	java -jar $BUILDDIR/openapi-generator-cli.jar \
		generate \
		-o "$BUILDDIR/$PROJECT_NAME" \
		-g go \
        --global-property models,supportingFiles=utils.go,modelDocs=false \
        --additional-properties  \
        --minimal-update \
        -p enumClassPrefix=true \
		-i ../ya-client/specs/${NAME}-api.yaml \
		--skip-validate-spec --strict-spec false 
}

gen activity 	0.1.0
gen payment		0.1.0
gen market		0.1.0
