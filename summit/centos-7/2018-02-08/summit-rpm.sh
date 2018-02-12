#!/bin/bash

mkdir ./summit_rpm

# Spectrum MPI
cp /ccs/packages/IBM/PRPQ-4Q17-Update/smpi/ibm_smpi-10.02.00.00prpq-rh7_20171117.ppc64le.rpm            ./summit_rpm
cp /ccs/packages/IBM/PRPQ-4Q17-Update/smpi/ibm_smpi-pami_devel-10.02.00.00prpq-rh7_20171117.ppc64le.rpm ./summit_rpm
cp /ccs/packages/IBM/PRPQ-4Q17-Update/smpi/ibm_smpi_lic_s-10.02.00dev0-rh7_20171107.ppc64le.rpm         ./summit_rpm
cp /ccs/packages/IBM/PRPQ-4Q17-Update/smpi/ibm_smpi-devel-10.02.00.00prpq-rh7_20171117.ppc64le.rpm      ./summit_rpm

# Mellanox OFED - directory created by mounting MLNX_OFED_LINUX-4.1-4.1.5.2-rhel7.4alternate-ppc64le.iso
cp -r /ccs/packages/IBM/PRPQ-4Q17/mellanox ./summit_rpm
# Remove large OFED packages that aren't required
chmod +w -R ./summit_rpm/mellanox
rm ./summit_rpm/mellanox/RPMS/mft-4.7.1-7.ppc64le.rpm
rm ./summit_rpm/mellanox/RPMS/mlnx-fw-updater-4.1-4.1.5.2.ppc64le.rpm
rm ./summit_rpm/mellanox/RPMS/openmpi-2.1.2a1-1.41102.ppc64le.rpm
rm ./summit_rpm/mellanox/RPMS/mlnx-ofa_kernel-devel-4.1-OFED.4.1.4.1.5.1.g773619a.rhel7u4alternate.ppc64le.rpm

tar -zcvf ./summit_rpm.tar.gz ./summit_rpm
rm -rf ./summit_rpm