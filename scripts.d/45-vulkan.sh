#!/bin/bash

LOADER_REPO="https://github.com/KhronosGroup/Vulkan-Loader.git"
LOADER_COMMIT="039cea5353be38656b67c683aa6325c01bce6e7e"

ffbuild_enabled() {
    return -1
}

ffbuild_dockerstage() {
    to_df "RUN --mount=src=${SELF},dst=/stage.sh --mount=src=patches/vulkan,dst=/patches run_stage /stage.sh"
}

ffbuild_dockerbuild() {
    git clone "$LOADER_REPO" loader
    git -C loader checkout "$LOADER_COMMIT"

    for patch in /patches/*.patch; do
        echo "Applying $patch"
        git -C loader am -3 < "$patch"
    done

    HEADERS_REPO="$(grep -A10 'name.*:.*Vulkan-Headers' loader/scripts/known_good.json | grep url | head -n1 | cut -d'"' -f4)"
    HEADERS_COMMIT="$(grep -A10 'name.*:.*Vulkan-Headers' loader/scripts/known_good.json | grep commit | head -n1 | cut -d'"' -f4)"

    git-mini-clone "$HEADERS_REPO" "$HEADERS_COMMIT" headers

    cd headers

    mkdir build && cd build

    cmake -DCMAKE_TOOLCHAIN_FILE="$FFBUILD_CMAKE_TOOLCHAIN" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$FFBUILD_PREFIX" ..
    make -j$(nproc)
    make install

    cd ../../loader

    mkdir build && cd build

    cmake -DCMAKE_TOOLCHAIN_FILE="$FFBUILD_CMAKE_TOOLCHAIN" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$FFBUILD_PREFIX" -DBUILD_TESTS=OFF -DBUILD_STATIC_LOADER=ON ..
    make -j$(nproc)
    make install

    ln -s libvulkan-1.a /opt/ffbuild/lib/libvulkan.a
}

ffbuild_configure() {
    echo --enable-vulkan
}

ffbuild_unconfigure() {
    echo --disable-vulkan
}
