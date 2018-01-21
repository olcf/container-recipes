#!/bin/bash

# Get script directory 
set -e

# Get script directory
SCRIPT_DIR=$(dirname $0)

# Titan doesn't include the necessary certificates so a copy is provided
export OS_CACERT=${SCRIPT_DIR}/OpenStack.cer
echo "using OS_CACERT="${OS_CACERT}

# Authenticate to OpenStack so we can create Kitchen instance
source ${SCRIPT_DIR}/openrc.sh

# Token to tie runner to container-recipes repo
echo "Please enter your Gitlab runner registration token: "
read -sr GITLAB_RUNNER_TOKEN_INPUT
export GITLAB_RUNNER_TOKEN=${GITLAB_RUNNER_TOKEN_INPUT}

# Token to allow read/write to registry(and any other api call). This is linked to user atj
echo "Please enter the container-recipe docker registry personal access token: "
read -sr GITLAB_REGISTRY_TOKEN_INPUT
export GITLAB_REGISTRY_TOKEN=${GITLAB_REGISTRY_TOKEN_INPUT}

set -o xtrace

# Destroy existing ContainerKitchen instance if one exists
./destroy-kitchen.sh --no_login

# General VM settings
BOOTIMG="CADES_Ubuntu16.04_v20170804_1"
ZONE="nova"
FLAVOR="m1.large"
NIC=$(openstack network show -c id --format value or_provider_general_extnetwork1)

# Create a new keypair
KEY="KitchenKey"
KEY_FILE="${SCRIPT_DIR}/${KEY}"
openstack keypair create ${KEY} > ${KEY_FILE}
chmod 600 ${KEY_FILE}

echo "Bringing up VM"
VM_UUID=$(openstack server create                                       \
    --image "${BOOTIMG}"                                                \
    --flavor "${FLAVOR}"                                                \
    --availability-zone "${ZONE}"                                       \
    --nic net-id="${NIC}"                                               \
    --key-name "${KEY}"                                                 \
    --wait                                                              \
    -c id                                                               \
    -f value                                                            \
    "ContainerKitchen");

# Get IP address of new instance
VM_IP=$(openstack server show -c addresses --format value ${VM_UUID} | sed -e "s/^or_provider_general_extnetwork1=//")

echo "Waiting for SSH to come up"
function ssh_is_up() {
    ssh -o StrictHostKeyChecking=no -i ${KEY_FILE} cades@${VM_IP} exit &> /dev/null
}
while ! ssh_is_up; do
    sleep 1
done

echo "Fixing ORNL TCP timeout issue for current session"
ssh -o StrictHostKeyChecking=no -i ${KEY_FILE} cades@${VM_IP} 'sudo bash -s' < ${SCRIPT_DIR}/disable_TCP_timestamps.sh

echo "Provisioning the kitchen"
ssh -o StrictHostKeyChecking=no -i ${KEY_FILE} cades@${VM_IP} 'sudo bash -s' < ${SCRIPT_DIR}/provision_kitchen.sh

echo "Copying gitlab registry credentials"
ssh -o StrictHostKeyChecking=no -i ${KEY_FILE} cades@${VM_IP} 'sudo bash -s' < ${SCRIPT_DIR}/gitlab_registry_token.sh ${GITLAB_REGISTRY_TOKEN}

echo "Starting Gitlab runner"
ssh -o StrictHostKeyChecking=no -i ${KEY_FILE} cades@${VM_IP} "sudo gitlab-runner register --non-interactive --tag-list 'kitchen, container-recipes' --name kitchen-runner --executor shell --url https://code.ornl.gov --registration-token ${GITLAB_RUNNER_TOKEN}"

echo "Updating qemu-ppc64le binary in rep"
scp -o StrictHostKeyChecking=no -i ${KEY_FILE} cades@${VM_IP}:/usr/bin/qemu-ppc64le ${SCRIPT_DIR}/../summitdev
git add ${SCRIPT_DIR}/../summitdev/qemu-ppc64le
git commit -m "updating qemu-ppc64le"
git push https://atj:${GITLAB_REGISTRY_TOKEN}@code.ornl.gov/olcf/container-recipes.git --all
