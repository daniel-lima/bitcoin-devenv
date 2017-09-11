---
title: Containerization (Docker)
---
Installing the prerequisites
-----------

1. Access [https://docs.docker.com/engine/installation](https://docs.docker.com/engine/installation)

2. Select the CE version suitable to your architecture+operating system (for instance, the instructions for Docker CE on Ubuntu would be [https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/))

3. Follow the instructions on how to install docker

4. Access [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)

5. Select the tab corresponding to your operating system

6. Follow the instructions on how to install docker-compose

7. Test the installed softwares

   ```docker --version```

   ```docker-compose --version```


Building the environment
--------------------

- [How to compile Bitcoin Core for Ubuntu](how-to/compile-bitcoin-core-for-ubuntu.md)
- [How to compile Bitcoin Core for Windows](how-to/compile-bitcoin-core-for-windows.md)


How does it work?
-----------------
Containerization is achieved by the combination of the following resources:

- Dockerfiles describing how the images should be built;
- shell scripts to install the necessary softwares into those images;
- docker-compose files defining the dependencies between the images and how to build containers from them.

To assemble the environment, a main docker-compose.yaml is chained together with complementary docker-compose.yaml files as demonstrated by [Step 4 - Start the docker container](how-to/compile-bitcoin-core-for-ubuntu.md#step-4).

Each guest container bindmounts a specific host folder as a container volume.
This allows developers to use full IDEs on the host env, for source code edition, while the compiler toolset rests on the guest container.

On the host environment, the base directory of this shared folder is ".." (which can be changed).
On the guest container, the base directory of the mount point is "/projects" (which **cannot** be changed).

To change the base dir on the host env, you should define a env var called PROJECTS_DIR.
For instance, on \*nix systems:

    export PROJECTS_DIR=/home/user/projects


What does each container contain?
------------------

- [Bitcoin Core containers](containers-bitcoin.md)
