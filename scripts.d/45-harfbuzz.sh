#!/bin/bash

HARFBUZZ_REPO="https://github.com/harfbuzz/harfbuzz.git"
HARFBUZZ_COMMIT="7236c7e29cef1c2d76c7a284c5081ff4d3aa1127"

ffbuild_enabled() {
    return 0
}

ffbuild_dockerstage() {
    to_df "ADD $SELF /stage.sh"
    to_df "RUN run_stage"
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

    ./autogen.sh "${myconf[@]}" || return -1
    make -j$(nproc) || return -1
    make install || return -1

    cd ..
    rm -rf harfbuzz
}
