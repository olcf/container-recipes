# Creating base containers

To create a docker base container the following steps must be preformed

- Run `SummitdevRPM.sh` on Titan to produce `summitdev_rpm.tar.gz`
- Commit `summitdev_rpm.tar.gz` to the repo so a history is maintained of the libraries used
- Clone this repo to the build host
  - the build host must have docker build capabilities
  - binfmt must be setup such that static `/usr/bin/qemu-ppc64le` is available
- Build the container 
  - `docker build -t code.ornl.gov:4567/olcf/container-recipes/{system}/{distro}_{version}:{yyyy-mm-dd} .`
  - e.g. `docker build -t code.ornl.gov:4567/olcf/container-recipes/Summitdev/Centos_7:2018-01-30 .`
- Push to the registry `docker push code.ornl.gov:4567/olcf/container-recipes`