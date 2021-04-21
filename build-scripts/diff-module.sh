#! /bin/bash

NAME=$1
DEST=$2

test -n "$NAME" || exit 1

if test -n "$DEST"; then
    diff -r -c "target/ya-$NAME" "pkg/ya-$NAME" > patches/$DEST
else
    diff -r -c "target/ya-$NAME" "pkg/ya-$NAME"
fi
