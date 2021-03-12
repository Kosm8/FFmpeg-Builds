#!/bin/bash

FDKAAC_REPO="https://github.com/mstorsjo/fdk-aac.git"
FDKAAC_COMMIT="0a90c09e00c3f6238efe8c89daf2c7e55ea4f011"

ffbuild_enabled() {
    [[ $VARIANT != nonfree* ]] && return -1
    return 0
}

ffbuild_dockerstage() {
    to_df "ADD $SELF /stage.sh"
    to_df "RUN run_stage"
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

    ./configure "${myconf[@]}" || return -1
    make -j$(nproc) || return -1
    make install || return -1

    cd ..
    rm -rf fdkaac
}

ffbuild_configure() {
    echo --enable-libfdk-aac
}

ffbuild_unconfigure() {
    echo --disable-libfdk-aac
}
