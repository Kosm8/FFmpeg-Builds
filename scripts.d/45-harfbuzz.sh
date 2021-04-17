#!/bin/bash

HARFBUZZ_REPO="https://github.com/harfbuzz/harfbuzz.git"
HARFBUZZ_COMMIT="19e096aa97b1b3af21313df5250a937ddfece7fb"

ffbuild_enabled() {
    return 0
}

ffbuild_dockerbuild() {
    git-mini-clone "$HARFBUZZ_REPO" "$HARFBUZZ_COMMIT" harfbuzz
    cd harfbuzz

    local myconf=(
        --prefix="$FFBUILD_PREFIX"
        --disable-shared
        --enable-static
        --with-pic
    )

    if [[ $TARGET == win* ]]; then
        myconf+=(
            --host="$FFBUILD_TOOLCHAIN"
        )
    else
        echo "Unknown target"
        return -1
    fi

    export LIBS="-lpthread"

    ./autogen.sh "${myconf[@]}"
    make -j$(nproc)
    make install
}
