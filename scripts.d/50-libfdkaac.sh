#!/bin/bash

FDKAAC_REPO="https://github.com/mstorsjo/fdk-aac.git"
FDKAAC_COMMIT="801f67f671929311e0c9952c5f92d6e147c7b003"

ffbuild_enabled() {
    [[ $VARIANT != nonfree* ]] && return -1
    return 0
}

ffbuild_dockerbuild() {
    git-mini-clone "$FDKAAC_REPO" "$FDKAAC_COMMIT" fdkaac
    cd fdkaac

    ./autogen.sh || return -1

    local myconf=(
        --prefix="$FFBUILD_PREFIX"
        --disable-shared
        --enable-static
    )

    if [[ $TARGET == win* ]]; then
        myconf+=(
            --host="$FFBUILD_TOOLCHAIN"
        )
    else
        echo "Unknown target"
        return -1
    fi

    ./configure "${myconf[@]}"
    make -j$(nproc)
    make install
}

ffbuild_configure() {
    echo --enable-libfdk-aac
}

ffbuild_unconfigure() {
    echo --disable-libfdk-aac
}
