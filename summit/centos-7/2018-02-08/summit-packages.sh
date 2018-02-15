#!/bin/bash

TOP_DIR=`pwd`

mkdir ${TOP_DIR}/summit-packages

# Spectrum MPI
mkdir ${TOP_DIR}/summit-packages/smpi
cp /ccs/packages/IBM/02-2018/SMPI/ibm_smpi-10.2.0.0-20180110-rh7.ppc64le.tar.gz ${TOP_DIR}/summit-packages/smpi
cd ${TOP_DIR}/summit-packages/smpi
tar -xf ibm_smpi-10.2.0.0-20180110-rh7.ppc64le.tar.gz

# CSM
mkdir ${TOP_DIR}/summit-packages/csm
cp /ccs/packages/IBM/PRPQ-4Q17-Update2/csm/ibm-csm-core-0.3.2-7694_prpq.ppc64le.rpm ${TOP_DIR}/summit-packages/csm

# Mellanox OFED - directory created by mounting MLNX_OFED_LINUX-4.1-4.1.5.2-rhel7.4alternate-ppc64le.iso
cp -r /ccs/packages/IBM/PRPQ-4Q17/mellanox ${TOP_DIR}/summit-packages
# Remove large OFED packages that aren't required
chmod +w -R ${TOP_DIR}/summit-packages/mellanox
rm ${TOP_DIR}/summit-packages/mellanox/RPMS/mft-4.7.1-7.ppc64le.rpm
rm ${TOP_DIR}/summit-packages/mellanox/RPMS/mlnx-fw-updater-4.1-4.1.5.2.ppc64le.rpm
rm ${TOP_DIR}/summit-packages/mellanox/RPMS/openmpi-2.1.2a1-1.41102.ppc64le.rpm
rm ${TOP_DIR}/summit-packages/mellanox/RPMS/mlnx-ofa_kernel-devel-4.1-OFED.4.1.4.1.5.1.g773619a.rhel7u4alternate.ppc64le.rpm

cd ${TOP_DIR}
tar -zcvf ./summit-packages.tar.gz ./summit-packages
rm -rf ${TOP_DIR}/summit-packages