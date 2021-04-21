#! /bin/bash

MODULES="market payment activity"

fail() {
	echo $@ >&2
	exit 1
}

echo step 1 cleaning pkg

set -x

rm -fr pkg

echo step 2 move modules into pkg
mkdir pkg
for name in $MODULES
do
  cp -r "target/ya-$name" pkg/
done

apply_patches() {
  local dst="$1"
  local modules="$2"

  for patch in patches/*.patch
  do
    test -f $patch || break
    for name in $modules; do
      patch -d "$dst/ya-$name" -p2 < $patch
    done
  done
  for module in $modules; do
    test -d "patches/$module" || continue
    for patch in patches/$module/*.patch; do
      test -f $patch || break
      patch -d "$dst/ya-$module" -p2 < $patch
    done
  done

}
echo step 3 apply patches
apply_patches "pkg" "$MODULES"
