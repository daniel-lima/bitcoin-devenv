---
title: How to run Bitcoin Core from Ubuntu
---

To run a **development** version of Bitcoin Core from a docker container with Ubuntu:

#### Preparing the environment

1\. Follow the instructions on [How to compile Bitcoin Core for Ubuntu](compile-bitcoin-core-for-ubuntu.md)

#### Running the software

2\. Install Bitcoin Core

Inside the docker container:

    exit

From the host machine:

    docker exec -u root -t bitcoin.ubuntu bash -c "cd /projects/bitcoin ; make install"

3\. Run it!

    docker exec -it bitcoin.ubuntu bash

Inside the guest container:

    bitcoind -daemon

    bitcoin-cli getblockchaininfo

    bitcoin-cli stop

Detailed running instructions at [Bitcoin It - Running Bitcoin](https://en.bitcoin.it/wiki/Running_Bitcoin)