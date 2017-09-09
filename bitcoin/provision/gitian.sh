#!/bin/bash

set -e

_INC_ONLY=1 source "${BASE_DIR}/provision/_base.sh"

bitcoin_gitian() {
    ## https://github.com/bitcoin/bitcoin/blob/master/doc/gitian-building.md

    # Setting up Debian for Gitian building
    apt-get -y install git ruby sudo apt-cacher-ng qemu-utils debootstrap lxc python-cheetah parted kpartx bridge-utils make ubuntu-archive-keyring curl

    # the version of lxc-start in Debian needs to run as root, so make sure
    # that the build script can execute it without providing a password
    echo "%sudo ALL=NOPASSWD: /usr/bin/lxc-start" > /etc/sudoers.d/gitian-lxc
    echo "%sudo ALL=NOPASSWD: /usr/bin/lxc-execute" >> /etc/sudoers.d/gitian-lxc
    # make /etc/rc.local script that sets up bridge between guest and host
    echo '#!/bin/sh -e' > /etc/rc.local
    echo 'brctl addbr br0' >> /etc/rc.local
    echo 'ifconfig br0 10.0.3.2/24 up' >> /etc/rc.local
    echo 'iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE' >> /etc/rc.local
    echo 'echo 1 > /proc/sys/net/ipv4/ip_forward' >> /etc/rc.local
    echo 'exit 0' >> /etc/rc.local


    local USER_HOME=$(cat /etc/passwd | grep "${BASE_SYSTEM_USER}" | cut -d ':' -f 6)
    local USER_PROFILE="${USER_HOME}/.profile"
    if [ -f "${USER_PROFILE}" ]; then
        # delete existing lines
        sed -i '/.*export \(USE_LXC\|GITIAN_HOST_IP\|LXC_GUEST_IP\).*/d' "${USER_PROFILE}"
    fi
        
    # make sure that USE_LXC is always set when logging in as debian,
    # and configure LXC IP addresses
    echo 'export USE_LXC=1' >> "${USER_PROFILE}"
    echo 'export GITIAN_HOST_IP=10.0.3.2' >> "${USER_PROFILE}"
    echo 'export LXC_GUEST_IP=10.0.3.5' >> "${USER_PROFILE}"

    # There is no python-vm-builder package in Debian, so we need to install it from source ourselves
    wget http://archive.ubuntu.com/ubuntu/pool/universe/v/vm-builder/vm-builder_0.12.4+bzr494.orig.tar.gz
    if echo "76cbf8c52c391160b2641e7120dbade5afded713afaa6032f733a261f13e6a8e  vm-builder_0.12.4+bzr494.orig.tar.gz" | sha256sum -c; then
        # (verification -- must return OK)
        tar -zxvf vm-builder_0.12.4+bzr494.orig.tar.gz
        cd vm-builder-0.12.4+bzr494
        python setup.py install
    fi

    
    echo 'Please, reboot your system before using it for the first time!!!'
}


_run $*
