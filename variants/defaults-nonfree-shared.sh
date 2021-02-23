#!/bin/bash
source "$(dirname "$BASH_SOURCE")"/defaults-nonfree.sh
FF_CONFIGURE+=" --enable-shared --disable-static"
