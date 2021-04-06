#!/bin/bash

RAV1E_REPO="https://github.com/xiph/rav1e.git"
RAV1E_COMMIT="ef9c3b7bb3caf682a083ada05c9e8812aa2568b1"

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
