# Setting up the build host
Before container-recipes CI tasks can be performed an appropriate build host must be created that's running a gitlab runner. 
Currently OpenStack provision scripts are provided which will allow a build instance to be spun up anywhere on the ORNL network and also the Titan login nodes. 
The following steps may be taken to create such a host, a "kitchen" suitable to build the container recipes in, if you will.

Prerequisite: Install `python-openstackclient`
* pip install --user python-openstackclient

To run
* cd kitchen_recipes
* ./create_kitchen
  * You will be prompted for your OpenStack password as well as the GitLab runner registration token

If the instance is created without error you should be able to enable the runner for container-recipes through the gitlab web ui. `KitchenKey` will be placed
in the `kitchen_scripts` directory and can be used to ssh to the Kitchen instance as the `cades` user.

# openrc.sh creation

The openrc.sh file under KitchenScripts sets up OpenStack credentials and was created as follows:
* Login to `cloud.cades.ornl.gov`
* Navigate to `Compute -> Access & Security -> API Access`
* Click `Download OpenStack RC File v3`
* Rename downloaded file as openrc.sh and move it to `container-recipes/KitchenScripts`
* Add the following to the bottom of `openrc.sh`

```
export OS_PROJECT_DOMAIN_NAME=$OS_USER_DOMAIN_NAME
export OS_IDENTITY_API_VERSION="3"
```