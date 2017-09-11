---
title: How to compile Bitcoin Core for Ubuntu
---
#### Creating the environment

The following steps need to be executed just once

1\. Clone or download Bitcoin Core

    git clone https://github.com/bitcoin/bitcoin.git


2\. Clone or download Bitcoin Development Environment

    git clone https://github.com/daniel-lima/bitcoin-devenv


3\. Build the docker images

    cd bitcoin-devenv

    docker-compose -f docker-compose.yml -f bitcoin/docker-compose.ubuntu.yml build

(It will take a while)


<a name="step-4"></a>4\. Start the docker container

    docker-compose -f docker-compose.yml -f bitcoin/docker-compose.ubuntu.yml up -d


#### Building the software

5\. Connect to the docker (guest) container

    docker exec -it bitcoin.ubuntu bash


6\. Build Bitcoin Core

Inside the guest container:

    cd /projects/bitcoin

    ./autogen.sh

    ./configure

    make

Detailed build instructions at [Bitcoin Core - UNIX BUILD NOTES](https://github.com/bitcoin/bitcoin/blob/master/doc/build-unix.md)


#### Extra commands

To check the container status (from the host machine):

    docker ps

To stop it:

    docker stop bitcoin.ubuntu

To bring it to life again:

    docker start bitcoin.ubuntu

To destroy the container and free the corresponding resources:

    docker stop bitcoin.ubuntu
    
    docker rm bitcoin.ubuntu

To rebuild the container and start everything again, go to [step 4](#step-4)
