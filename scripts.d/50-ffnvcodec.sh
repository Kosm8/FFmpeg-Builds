#!/bin/bash

SCRIPT_REPO="https://github.com/FFmpeg/nv-codec-headers.git"
SCRIPT_COMMIT="master"

SCRIPT_REPO2="https://github.com/FFmpeg/nv-codec-headers.git"
SCRIPT_COMMIT2="sdk/12.0"
SCRIPT_BRANCH2="sdk/12.0"

SCRIPT_REPO3="https://github.com/FFmpeg/nv-codec-headers.git"
SCRIPT_COMMIT3="sdk/12.1"
SCRIPT_BRANCH3="sdk/12.1"

SCRIPT_REPO4="https://github.com/FFmpeg/nv-codec-headers.git"
SCRIPT_COMMIT4="sdk/12.2"
SCRIPT_BRANCH4="sdk/12.2"

ffbuild_enabled() {
    [[ $TARGET == winarm64 ]] && return -1
    return 0
}

ffbuild_dockerdl() {
    default_dl ffnvcodec
    echo "git-mini-clone \"$SCRIPT_REPO2\" \"$SCRIPT_COMMIT2\" ffnvcodec2"
    echo "git-mini-clone \"$SCRIPT_REPO3\" \"$SCRIPT_COMMIT3\" ffnvcodec3"
    echo "git-mini-clone \"$SCRIPT_REPO4\" \"$SCRIPT_COMMIT4\" ffnvcodec4"
}

ffbuild_dockerbuild() {
    if [[ $ADDINS_STR == *4.4* || $ADDINS_STR == *5.0* || $ADDINS_STR == *5.1* || $ADDINS_STR == *6.0* || $ADDINS_STR == *6.1* ]]; then
        cd ffnvcodec2
    elif [[ $ADDINS_STR == *7.0* ]]; then
        cd ffnvcodec3
    elif [[ $ADDINS_STR == *7.1* ]]; then
        cd ffnvcodec4
    else
        cd ffnvcodec
    fi

    make PREFIX="$FFBUILD_PREFIX" install
}

ffbuild_configure() {
    echo --enable-ffnvcodec --enable-cuda-llvm
}

ffbuild_unconfigure() {
    echo --disable-ffnvcodec --disable-cuda-llvm
}

ffbuild_cflags() {
    return 0
}

ffbuild_ldflags() {
    return 0
}
