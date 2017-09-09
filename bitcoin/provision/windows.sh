#!/bin/bash

set -e

_INC_ONLY=1 source "${BASE_DIR}/bitcoin/provision/_base.sh"

bitcoin_windows() {
    ## https://github.com/bitcoin/bitcoin/blob/master/doc/build-windows.md
    
    # Windows cross-compilation        
    apt-get -y install curl
    
    apt-get -y install g++-mingw-w64-x86-64 mingw-w64-x86-64-dev
    
    apt-get -y install g++-mingw-w64-i686 mingw-w64-i686-dev
}

_run $*
