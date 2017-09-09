Bitcoin Development Environment
========

Aims to simplify the creation and management of dev envs used to compile and test Bitcoin software, such as Bitcoin Core.

The "magic" would happen either through containerization or virtualization.


Quick start instructions
----------

For containerization, if you already have [docker](https://docs.docker.com/engine/reference/commandline/cli/) and [docker-compose](https://docs.docker.com/compose/reference/) properly installed:
- [How to compile Bitcoin Core for Ubuntu](docker/how-to/compile-bitcoin-core-for-ubuntu.md)
- [How to compile Bitcoin Core for Windows](docker/how-to/compile-bitcoin-core-for-windows.md)


For virtualization, if you already have [vagrant](https://www.vagrantup.com/docs/cli/) and [VBoxManage](https://www.virtualbox.org/manual/ch08.html) properly installed:
- [How to compile Bitcoin Core for Ubuntu](vagrant/how-to/compile-bitcoin-core-for-ubuntu.md)
- [How to compile Bitcoin Core for Windows](vagrant/how-to/compile-bitcoin-core-for-windows.md)
- [How to deterministically build Bitcoin Core (Gitian)](vagrant/how-to/deterministically-build-bitcoin-core.md)


Detailed guides
---------------

- [Containerization via Docker](docker/index.md)
- [Virtualization via Vagrant and VirtualBox](vagrant/index.md)


Warning!!!
--------

Do not use this tool to build **production ready** versions of Bitcoin Core or any Bitcoin related software!

The reliability of the base [Docker images](https://hub.docker.com/) and the base [Vagrant boxes](https://app.vagrantup.com/boxes/search) is unknown, so you should **not** expose your (true) private keys to them or to softwares built in/from them.

If you're trying to produce deterministic builds and **you know what you're doing** and you have enough signatures to verify the generated artifacts, you may want to check [bitcoin.gitian - Vagrant machine](vagrant/how-to/deterministically-build-bitcoin-core.md).

