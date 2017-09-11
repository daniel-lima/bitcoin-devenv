---
title: How to compile Bitcoin Core for Ubuntu
---
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

    vagrant up bitcoin.ubuntu

(The first time will take a while)


#### Building the software

5\. Connect to the vagrant (guest) machine

    vagrant ssh bitcoin.ubuntu

6\. Build Bitcoin Core

Inside the guest machine:

    cd /projects/bitcoin

    ./autogen.sh

    ./configure

    make

Detailed build instructions at [Bitcoin Core - UNIX BUILD NOTES](https://github.com/bitcoin/bitcoin/blob/master/doc/build-unix.md)


#### Extra commands

To check the machine status (from the host machine):

    vagrant status

To stop it:

    vagrant halt bitcoin.ubuntu

To bring it to life again:

    vagrant up bitcoin.ubuntu

To destroy the machine and free the corresponding resources:

    vagrant destroy bitcoin.ubuntu

To rebuild the machine and start everything again, go to [step 4](#step-4)
