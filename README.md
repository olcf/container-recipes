# Setting up the build host
Before container-recipes CI tasks can be performed an appropriate build host must be created.

Prerequisite: On Titan
* module load python
* pip install --user python-openstackclient

Servers may be spun up anywhere on the ORNL network and also the Titan login nodes. To obtain the credentials required for access take the following steps.
* Login to `cloud.cades.ornl.gov`
* Navigate to `Compute -> Access & Security -> API Access`
* Click `Download OpenStack RC File v3`
* Rename downloaded file as openrc.sh and move it to `container-recipes/KitchenScripts`
* Add the following to the bottom of `openrc.sh`

```
export OS_PROJECT_DOMAIN_NAME=$OS_USER_DOMAIN_NAME
export OS_IDENTITY_API_VERSION="3"
```

* ./CreateKitchen

After the host is setup the runner that's been created must be setup in the GitLab `CI/CD` settings