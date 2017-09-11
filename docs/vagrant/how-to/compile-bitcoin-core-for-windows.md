---
title: How to compile Bitcoin Core for Windows
---
How to compile Bitcoin Core for Windows
========


#### Creating the environment

The following steps need to be executed just once

1\. Clone or download Bitcoin Core

    git clone https://github.com/bitcoin/bitcoin.git

2\. Clone or download Bitcoin Development Environment

    git clone https://github.com/daniel-lima/bitcoin-devenv

3\. Move to the base directory

    cd bitcoin-devenv

4\. Build and start the vagrant machine

    export BOX_OPTS="-l bitcoin/Vagrantfile"

    vagrant up bitcoin.windows

(The first time will take a while)


#### Building the software

5\. Connect to the vagrant (guest) machine

    vagrant ssh bitcoin.windows

6\. Build Bitcoin Core

Inside the guest machine:

    cd /projects/bitcoin

    cd depends


To build for 64 bits:

    make HOST=x86_64-w64-mingw32

    cd ..

    ./autogen.sh # not required when building from tarball

    CONFIG_SITE=$PWD/depends/x86_64-w64-mingw32/share/config.site ./configure --prefix=/

    make


Detailed build instructions at [Bitcoin Core - WINDOWS BUILD NOTES](https://github.com/bitcoin/bitcoin/blob/master/doc/build-windows.md)


#### Extra commands

To check the machine status (from the host machine):

    vagrant status

To stop it:

    vagrant halt bitcoin.windows

To bring it to life again:

    vagrant up bitcoin.windows

To destroy the machine and free the corresponding resources:

    vagrant destroy bitcoin.windows

To rebuild the machine and start everything again, go to [step 4](#step-4)
