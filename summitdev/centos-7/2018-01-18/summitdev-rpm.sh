#!/bin/bash

# The following script will create summitdev_rpm.tar.gz container all Summitdev specific libraries
mkdir ./summitdev_rpm

cp /sw/summitdev/spectrum_mpi/10.1.0.4-20170915/rpms/ibm_smpi-10.1.0.4-rh7.ppc64le.rpm ./summitdev_rpm
cp /sw/summitdev/spectrum_mpi/10.1.0.4-20170915/rpms/ibm_smpi_lic_s-10.1-rh7.ppc64le.rpm ./summitdev_rpm

tar -zcvf ./summitdev_rpm.tar.gz ./summitdev_rpm
rm -rf ./summitdev_rpm
