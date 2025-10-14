#!/bin/bash

SCRIPT_SKIP="1"

ffbuild_depends() {
    echo libiconv
    echo zlib
    echo fribidi
    echo libxml2
    echo openssl
    echo xz
    echo fonts
    echo opencl
    echo vulkan
    echo aribb24
    echo dav1d
    echo fdk-aac
    echo ffnvcodec
    echo libaribcaption
    echo libass
    echo libplacebo
    echo libssh
    echo libzmq
    echo schannel
    echo srt
    echo zimg
    echo zvbi
}

ffbuild_enabled() {
    return 0
}

ffbuild_dockerfinal() {
    return 0
}

ffbuild_dockerdl() {
    return 0
}

ffbuild_dockerlayer() {
    return 0
}

ffbuild_dockerstage() {
    return 0
}

ffbuild_dockerbuild() {
    return 0
}

ffbuild_ldexeflags() {
    return 0
}
