[Bitcoin] Development Environment
========

Build controlled dev envs to compile and test Bitcoin tools.

Detailed project documentation at: [http://daniel-lima.github.io/bitcoin-devenv](http://daniel-lima.github.io/bitcoin-devenv).


Quick start guides
--------

Using Docker

- How to compile Bitcoin Core for Ubuntu;
- How to compile Bitcoin Core for Windows;
- How to...

Using Vagrant

- How to compile Bitcoin Core for Ubuntu;
- How to compile Bitcoin Core for Windows;
- How to...


Warning!!!
--------

Do not use this tool to build **production ready** versions of Bitcoin Core or any Bitcoin related software!

The reliability of the base [Docker images](https://hub.docker.com/) and the base [Vagrant boxes](https://app.vagrantup.com/boxes/search) is unknown, so you should **not** expose your (true) private keys to them or to softwares built in/from them.

If you're trying to produce deterministic builds and **you know what you're doing** and you have enough signatures to verify the generated artifacts, you may want to check bitcoin.gitian - Vagrant machine.


License
--------

This environment builder is released under the terms of the [Apache License](LICENSE).


Motivation
--------

To experiment Bitcoin Core as a developer, I needed an enviroment:

1. Isolated from the host env;
2. Capable of being used in different computers;
3. Easy and quick to configure, install, reconfigure, reinstall and to uninstall.

So containerization and virtualization, through [Docker](https://www.docker.com/) and [Vagrant](https://www.vagrantup.com/), came to play.