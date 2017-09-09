#!/bin/bash

set -e

_INC_ONLY=1 source "${BASE_DIR}/bitcoin/provision/_base.sh"

bitcoin_ubuntu() {
    ## https://github.com/bitcoin/bitcoin/blob/master/doc/build-unix.md
    
    # boost
    apt-get -y install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
    
    # db4.8 (wallet compatibility)
    apt-get -y install software-properties-common
    add-apt-repository -y ppa:bitcoin/bitcoin
    apt-get -y update    
    
    apt-get -y install libdb4.8-dev libdb4.8++-dev   
    
    # optional
    apt-get -y install libminiupnpc-dev
    
    # ZMQ
    apt-get -y install libzmq3-dev
    
    # GUI
    apt-get -y install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler        

    ## https://github.com/bitcoin/bitcoin/blob/master/doc/gitian-building.md
    
    # Gitian build
    #apt-get -y install apache2 apt-cacher-ng python-vm-builder ruby qemu-utils
    
    #if ! lsb_release -c | grep -i trusty; then
        # lxc is broken for trusty (Ubuntu 14.04)
    #    apt-get -y install lxc
    #fi

}


_run $*
