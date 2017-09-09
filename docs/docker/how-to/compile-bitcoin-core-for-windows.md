How to compile Bitcoin Core for Windows
========


#### Creating the environment

The following steps need to be executed just once

1\. Clone or download Bitcoin Core

    git clone https://github.com/bitcoin/bitcoin.git


2\. Clone or download Bitcoin Development Environment

    git clone https://github.com/daniel-lima/bitcoin-devenv


3\. Build the docker images

    cd bitcoin-devenv

    docker-compose -f docker-compose.yml -f bitcoin/docker-compose.windows.yml build

(It will take a while)


<a name="step-4" ></a>4\. Start the docker container

    docker-compose -f docker-compose.yml -f bitcoin/docker-compose.windows.yml up -d



#### Building the software

5\. Connect to the docker (guest) container

    docker exec -it bitcoin.windows bash


6\. Build Bitcoin Core

Inside the guest container:

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

To check the container status (from the host machine):

    docker ps

To stop it:

    docker stop bitcoin.windows

To bring it to life again:

    docker start bitcoin.windows

To destroy the container and free the corresponding resources:

    docker stop bitcoin.windows
    
    docker rm bitcoin.windows

To rebuild the container and start everything again, go to [step 4](#step-4)
