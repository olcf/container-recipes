# Container Recipes
The `container-recipes` repository is a collection of recipe scripts and base images to facilitate building `Singularity` containers on OLCF HPC resources.

# Base Images
Creating containers for OLCF HPC systems requires special consideration due to proprietary system software such as `MPI` and `CUDA`. To allow users
the ability to create customized containers for use on these systems base configured `Docker` images are made available. Each base image comes pre-installed with the smallest
subset of proprietary system specific software required to run on the target system. These `Docker` base images can be used to bootstrap your own custom `Singularity` image.

Due the proprietary nature of software contained in these images access to them is granted through the OLCF [container-builder](https://github.com/olcf/container-builder).

# Recipe scripts
In addition to base images recipe files are provided for popular software stacks. These recipes can be built into Singularity images using the [container-builder](https://github.com/olcf/container-builder) utility.
