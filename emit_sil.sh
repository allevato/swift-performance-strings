#!/bin/bash
#
# Emits and demangles the canonical SIL for Tokenizing.

set -eu
readonly scriptdir="$(dirname "$0")"

xcrun swiftc -O -emit-sil \
    -module-name Tokenizing "$scriptdir"/Tokenizing/*.swift 2>&1 | \
    xcrun swift-demangle > Tokenizing.sil.txt
