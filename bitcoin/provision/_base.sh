#!/bin/bash

set -e

_INC_ONLY=1 source "${BASE_DIR}/provision/_base.sh"

bitcoin_base() {
    # build requirements 
    apt-get -y install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils
}

_run $*
