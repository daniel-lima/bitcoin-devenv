How to deterministically build Bitcoin Core (Gitian)
========


#### Creating the environment

The following steps need to be executed just once

1\. Clone or download Bitcoin Development Environment

    git clone https://github.com/daniel-lima/bitcoin-devenv

2\. Move to the base directory

    cd bitcoin-devenv

<a name="step-3"></a>3\. Build and start the vagrant machine

    export BOX_OPTS="-l bitcoin/Vagrantfile.gitian"

    vagrant up bitcoin.gitian

(The first time will take a while)

     After booting this machine for the first time, you need to restart it:

     vagrant reload bitcoin.gitian


#### Building the software

<a name="step-4"></a>4\. Connect to the vagrant (guest) machine

    vagrant ssh bitcoin.gitian


The build process happens enterily on the **guest** machine.
More precise and detailed instructions can be found on [Bitcoin Core - Gitian building](https://github.com/bitcoin/bitcoin/blob/master/doc/gitian-building.md) and on [Bitcoin Core - Release Process](https://github.com/bitcoin/bitcoin/blob/master/doc/release-process.md).

The following steps are an adapted version of those instructions:


5\. Create a local (non shared) directory

    cd ~

    mkdir gitian

    cd gitian

6\. Select a version and a signer

For example:

    export VERSION=0.15.0rc3
    export SIGNER=signer

7\. Get the latest version of the code from GitHub

    git clone https://github.com/bitcoin-core/gitian.sigs.git
    git clone https://github.com/bitcoin-core/bitcoin-detached-sigs.git
    git clone https://github.com/devrandom/gitian-builder.git
    git clone https://github.com/bitcoin/bitcoin.git

    pushd ./bitcoin
    git fetch
    git checkout v${VERSION}
    popd

    pushd ./gitian.sigs
    git pull
    popd

    pushd ./gitian-builder
    git pull
    popd


8\. Set up the Gitian image

     pushd gitian-builder
     bin/make-base-vm --lxc --arch amd64 --suite trusty
     popd


9\. Create the build inputs

    pushd ./gitian-builder
    mkdir -p inputs
    wget -P inputs https://bitcoincore.org/cfields/osslsigncode-Backports-to-1.7.1.patch
    wget -P inputs http://downloads.sourceforge.net/project/osslsigncode/osslsigncode/osslsigncode-1.7.1.tar.gz
    popd


10\. Seed the Gitian sources

    pushd ./gitian-builder
    make -C ../bitcoin/depends download SOURCES_PATH=`pwd`/cache/common
    popd


11\. Build the Bitcoin Core for Linux and Windows

     pushd ./gitian-builder
     
     ./bin/gbuild --num-make 3 --memory 6000 --commit bitcoin=v${VERSION} ../bitcoin/contrib/gitian-descriptors/gitian-linux.yml

     ./bin/gbuild --num-make 3 --memory 6000 --commit bitcoin=v${VERSION} ../bitcoin/contrib/gitian-descriptors/gitian-win.yml

     popd

_Tips_:

- To learn how increase the amount of memory and CPU used by this machine, check [the recipes](../recipes.md);
- To check the build status, open a new [SSH session to this machine](#step-4) and "tail" the logs at ~/gitian/gitian-builder: var/install.log and var/build.log. 


12\. Verify gitian builders signature

     gpg --import ./bitcoin/contrib/gitian-keys/*.pgp
     gpg --refresh-keys

     pushd ./gitian-builder
     ./bin/gverify -v -d ../gitian.sigs/ -r ${VERSION}-linux ../bitcoin/contrib/gitian-descriptors/gitian-linux.yml
     ./bin/gverify -v -d ../gitian.sigs/ -r ${VERSION}-win-unsigned ../bitcoin/contrib/gitian-descriptors/gitian-win.yml
     popd


#### Extra commands

To check the machine status (from the host machine):

    vagrant status

To stop it:

    vagrant halt bitcoin.gitian

To bring it to life again:

    vagrant up bitcoin.gitian

To destroy the machine and free the corresponding resources:

    vagrant destroy bitcoin.gitian

To rebuild the machine and start everything again, go to [step 3](#step-3)
