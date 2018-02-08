#!/bin/bash

# The following script will create summit_rpm.tar.gz containing Spectrum MPI RPMs
mkdir ./summit_rpm

cp /ccs/packages/IBM/PRPQ-4Q17-Update/smpi/ibm_smpi-10.02.00.00prpq-rh7_20171117.ppc64le.rpm            ./summit_rpm
cp /ccs/packages/IBM/PRPQ-4Q17-Update/smpi/ibm_smpi-pami_devel-10.02.00.00prpq-rh7_20171117.ppc64le.rpm ./summit_rpm
cp /ccs/packages/IBM/PRPQ-4Q17-Update/smpi/ibm_smpi_lic_s-10.02.00dev0-rh7_20171107.ppc64le.rpm         ./summit_rpm
cp /ccs/packages/IBM/PRPQ-4Q17-Update/smpi/ibm_smpi-devel-10.02.00.00prpq-rh7_20171117.ppc64le.rpm      ./summit_rpm

tar -zcvf ./summit_rpm.tar.gz ./summitdev_rpm
rm -rf ./summit_rpm
