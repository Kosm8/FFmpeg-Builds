# FFmpeg Static Auto-Builds

Static Windows Builds of ffmpeg master and latest release branch.

## Package List

For a list of included dependencies check the scripts.d directory.
Every file corresponds to its respective package.

## How to make a build

### Prerequisites

* bash
* docker

### Build Image

* `./makeimage.sh target variant [addins]`

### Build FFmpeg

* `./build.sh target variant [addins]`

On success, the resulting zip file will be in the `artifacts` subdir.

### Targets, Variants and Addins

The two available targets are `win32` and `win64`.

Available in `gpl` and `nonfree` variants.

All of those can be optionally combined with any combination of addins.
Currently that's `4.3`, to build from the 4.3 release branch instead of master.
`debug` to not strip debug symbols from the binaries. This increases the output size by about 250MB.
