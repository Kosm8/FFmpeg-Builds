#!/bin/bash

GLSLANG_REPO="https://github.com/KhronosGroup/glslang.git"
GLSLANG_COMMIT="9431c53c84c14fa9e9cd37678262ebba55c62c87"

ffbuild_enabled() {
    return -1
}

ffbuild_dockerbuild() {
    git-mini-clone "$GLSLANG_REPO" "$GLSLANG_COMMIT" glslang
    cd glslang

    python3 ./update_glslang_sources.py

    mkdir build && cd build

    cmake -DCMAKE_TOOLCHAIN_FILE="$FFBUILD_CMAKE_TOOLCHAIN" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$FFBUILD_PREFIX" -DBUILD_SHARED_LIBS=OFF -DBUILD_EXTERNAL=ON -DBUILD_TESTING=OFF -DENABLE_CTEST=OFF -DENABLE_HLSL=ON -DENABLE_GLSLANG_BINARIES=OFF ..
    make -j$(nproc)
    make install
}

ffbuild_configure() {
    echo --enable-libglslang
}

ffbuild_unconfigure() {
    echo --disable-libglslang
}
