# Setting up the build host
Before container-recipes CI tasks can be performed an appropriate build host must be created. This host must be capable of building the Docker containers and hosting a Gitlab runner. 
OpenStack provisioning scripts are provided which allow such a host to be stood up from the Titan login nodes.

### Prerequisites
* pip install --user python-openstackclient

### Provision
* cd kitchen_recipes
* ./create_kitchen
  * You will be prompted for your OpenStack password as well as the GitLab runner registration token

If the instance is created without error it will be setup to build and deploy containers on push. `KitchenKey` will be placed
in the `kitchen-scripts` directory and can be used to ssh to the Kitchen instance as the `cades` user. 

# openrc.sh creation
The openrc.sh file under KitchenScripts sets up OpenStack credentials and was created as follows:
* Login to `cloud.cades.ornl.gov`
* Navigate to `Compute -> Access & Security -> API Access`
* Click `Download OpenStack RC File v3`
* Rename downloaded file as openrc.sh and move it to `container-recipes/kitchen-scripts`
* Add the following to the bottom of `openrc.sh`

```
export OS_PROJECT_DOMAIN_NAME=$OS_USER_DOMAIN_NAME
export OS_IDENTITY_API_VERSION="3"
```