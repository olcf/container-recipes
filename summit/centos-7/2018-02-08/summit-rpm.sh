#!/bin/bash

mkdir ./summit_rpm

# Spectrum MPI
mkdir ./summit_rpm/smpi
cp /ccs/packages/IBM/02-2018/SMPI/ibm_smpi-10.2.0.0-20180110-rh7.ppc64le.tar.gz ./summit_rpm/smpi

# Mellanox OFED - directory created by mounting MLNX_OFED_LINUX-4.1-4.1.5.2-rhel7.4alternate-ppc64le.iso
cp -r /ccs/packages/IBM/PRPQ-4Q17/mellanox ./summit_rpm
# Remove large OFED packages that aren't required
chmod +w -R ./summit_rpm/mellanox
rm ./summit_rpm/mellanox/RPMS/mft-4.7.1-7.ppc64le.rpm
rm ./summit_rpm/mellanox/RPMS/mlnx-fw-updater-4.1-4.1.5.2.ppc64le.rpm
rm ./summit_rpm/mellanox/RPMS/openmpi-2.1.2a1-1.41102.ppc64le.rpm
rm ./summit_rpm/mellanox/RPMS/mlnx-ofa_kernel-devel-4.1-OFED.4.1.4.1.5.1.g773619a.rhel7u4alternate.ppc64le.rpm

tar -zcvf ./summit_rpm/mellanox.tar.gz ./summit_rpm/mellanox
rm -rf ./summit_rpm/mellanox

tar -zcvf ./summit_rpm.tar.gz ./summit_rpm
rm -rf ./summit_rpm