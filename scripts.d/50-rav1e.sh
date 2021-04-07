#!/bin/bash

RAV1E_REPO="https://github.com/xiph/rav1e.git"
RAV1E_COMMIT="ec272cc940794615b926ee04e4182cc459b6871e"

ffbuild_enabled() {
    [[ $TARGET == win32 ]] && return -1
    return 0
}

ffbuild_dockerbuild() {
    git-mini-clone "$RAV1E_REPO" "$RAV1E_COMMIT" rav1e
    cd rav1e

    cargo cinstall \
        --target="$FFBUILD_RUST_TARGET" \
        --prefix="$FFBUILD_PREFIX" \
        --library-type=staticlib \
        --crt-static \
        --release
}

ffbuild_configure() {
    echo --enable-librav1e
}

ffbuild_unconfigure() {
    [[ $VARIANT == *4.2* ]] && return 0
    echo --disable-librav1e
}
