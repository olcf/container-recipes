# Creating base containers

To create a docker base container the following steps must be preformed

- Run `TitanLib.sh` on titan to produce `titan_lib.tar.gz`
- Commit `titan_lib.tar.gz` to the repo so a history is maintained of the libraries used
- Clone this repo to the build host
- Build the container `docker build -t code.ornl.gov:4567/olcf/container-recipes/{system}/{distro}:{version} .`
  - `docker build -t code.ornl.gov:4567/olcf/container-recipes/Titan/Ubuntu:17.04 .`
- Push to the registry `docker push code.ornl.gov:4567/olcf/container-recipes`