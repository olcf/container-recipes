#!/bin/bash

# Get script directory
SCRIPT_DIR=$(dirname $0)

# OpenStack credentials
if [ "$1" != "--no_login" ]; then
    source ${SCRIPT_DIR}/openrc.sh
fi

# Delete VMs
openstack server list -f value --name Kitchen -c ID | while read ID; do
  echo "Deleting server ${ID}"
  openstack server delete --wait ${ID}
done

# Remove Key
if [ $(openstack keypair list | grep KitchenKey | wc -l) != 0 ]; then
    echo "Deleting KitchenKey"
    openstack keypair delete KitchenKey
    rm -f ${SCRIPT_DIR}/KitchenKey
fi
