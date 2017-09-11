---
title: Virtualization (Vagrant)
---
Installing the prerequisites
-----------

1. Access [https://www.vagrantup.com/downloads.html](https://www.vagrantup.com/downloads.html)

2. Download and install the package suitable to your architecture+operating system

3. Access [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)

4. Follow the instructions for your operating system

5. Test the installed softwares

   ```vagrant --version```

   ```VBoxManage --version```


Building the environment
--------------------
- [How to compile Bitcoin Core for Ubuntu](how-to/compile-bitcoin-core-for-ubuntu.md)
- [How to compile Bitcoin Core for Windows](how-to/compile-bitcoin-core-for-windows.md)
- [How to deterministically build Bitcoin Core (Gitian)](how-to/deterministically-build-bitcoin-core.md)


How does it work?
-----------------
Virtualization is achieved by the combination of the following resources:

- Vagrantfiles instructing how the machines should be built;
- shell scripts to install the necessary softwares into those machines.

To assemble the environment, the main Vagrantfile is chained together with other Vagrantfiles, as demonstrated on [Step 4 - Build and start the vagrant machine](how-to/compile-bitcoin-core-for-ubuntu.md#step-4).

Each virtual machine creates a synced folder mapped to a specific folder on the host machine.
This allows developers to use full IDEs on the host env, for source code edition, while the compiler toolset rests on the guest machine.

On the host environment, the base directory of this synced folder is ".." (which can be changed).
On the guest container, the base directory of the synced folder is "/projects" (which **cannot** be changed).

To change the base dir on the host env, you should add --project-dir to the box options.
For instance, on \*nix systems:

    export BOX_OPTS="-l bitcoin/Vagrantfile --projects-dir /home/user/projects"

Further information regarding options and usage patterns can be found on the [Recipes](recipes.md) page.

What does each virtual machine contains?
---------------

- [Bitcoin Core machines](machines-bitcoin.md)