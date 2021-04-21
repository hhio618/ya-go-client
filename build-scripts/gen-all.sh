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
		--additional-properties packageName=${NAME},enumClassPrefix=true,isGoSubmodule=true \
		--type-mappings=object=interface{} \
		--enable-post-process-file \
		--minimal-update \
        --global-property apiDocs=false,modelDocs=false \
		-i ../ya-client/specs/${NAME}-api.yaml \
		--skip-validate-spec --strict-spec false 
}

export GO_POST_PROCESS_FILE="../build-scripts/go-post-process.sh"
gen activity 	0.1.0
gen payment		0.1.0
gen market		0.1.0
