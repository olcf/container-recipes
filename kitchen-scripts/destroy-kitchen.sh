#!/bin/bash

# Get script directory
SCRIPT_DIR=$(dirname $0)

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