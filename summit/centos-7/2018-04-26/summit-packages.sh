#!/bin/bash

TOP_DIR=`pwd`

mkdir ${TOP_DIR}/summit-packages

# Spectrum MPI
mkdir ${TOP_DIR}/summit-packages/smpi
cp /ccs/packages/IBM/04-2018/smpi/ibm_smpi-10.2.0.0-20180406-rh7.ppc64le.tar.gz ${TOP_DIR}/summit-packages/smpi
cd ${TOP_DIR}/summit-packages/smpi
tar -xf ibm_smpi-10.2.0.0-20180406-rh7.ppc64le.tar.gz

# Update the JSM RPM
cp /ccs/packages/IBM/04-2018/smpi/ibm_smpi-jsm-10.02.00.00prpq-rh7_20180404.ppc64le.rpm ${TOP_DIR}/summit-packages/smpi

# Mellanox OFED - directory created by mounting MLNX_OFED_LINUX-4.1-4.1.5.2-rhel7.4alternate-ppc64le.iso
cp -r /ccs/packages/IBM/02-2018/mellanox ${TOP_DIR}/summit-packages

# Remove large OFED packages that aren't required
chmod +w -R ${TOP_DIR}/summit-packages/mellanox

cd ${TOP_DIR}
tar -zcvf ./summit-packages.tar.gz ./summit-packages
rm -rf ${TOP_DIR}/summit-packages
