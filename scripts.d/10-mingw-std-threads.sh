#!/bin/bash

SCRIPT_REPO="https://github.com/meganz/mingw-std-threads.git"
SCRIPT_COMMIT="master"

ffbuild_enabled() {
    [[ $TARGET == win* ]] || return -1
    return 0
}

ffbuild_dockerbuild() {
    mkdir -p "$FFBUILD_PREFIX"/include
    cp *.h "$FFBUILD_PREFIX"/include
}
