---
title: How to run Bitcoin Core from Ubuntu
---

To run a **development** version of Bitcoin Core from a Vagrant machine with Ubuntu:

#### Preparing the environment

1\. Follow the instructions on [How to compile Bitcoin Core for Ubuntu](compile-bitcoin-core-for-ubuntu.md)

#### Running the software

2\. Install Bitcoin Core

Inside the guest machine:

    sudo su
    
    cd /projects/bitcoin
    
    make install
    
    exit

3\. Run it!

    bitcoind -daemon

    bitcoin-cli getblockchaininfo

    bitcoin-cli stop

Detailed running instructions at [Bitcoin It - Running Bitcoin](https://en.bitcoin.it/wiki/Running_Bitcoin)