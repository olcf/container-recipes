FROM ppc64le/centos:7

COPY qemu-ppc64le-static /usr/bin/qemu-ppc64le-static
COPY summit_rpm.tar.gz /summit_rpm.tar.gz

ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH:-}:/usr/local/cuda/lib:/usr/local/cuda/lib64:/opt/ibm/spectrum_mpi/lib:/opt/ibm/spectrum_mpi/lib/spectrum_mpi:/opt/ibm/spectrum_mpi/jsm_pmix/lib
ENV PATH=${PATH:-}:/usr/local/cuda/bin:/opt/ibm/spectrum_mpi/bin:/opt/ibm/spectrum_mpi/jsm_pmix/bin
ENV OMPI_DIR=/opt/ibm/spectrum_mpi
ENV MPI_ROOT=/opt/ibm/spectrum_mpi
ENV OPAL_PREFIX=/opt/ibm/spectrum_mpi
ENV OPAL_LIBDIR=/opt/ibm/spectrum_mpi/lib
ENV OMPI_CC=gcc
ENV OMPI_CXX=g++
ENV OMPI_FC=gfortran
ENV PAMI_IBV_ENABLE_DCT=1
ENV PAMI_ENABLE_STRIPING=0

RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install wget gcc-c++ gcc-gfortran redhat-lsb glibc-static libstdc++-static numactl \
                   perl numactl-libs tcsh libnl tcl tk && \
    yum -y clean all && \
    rm -rf /var/cache/yum

# Install Spectrum MPI and Mellanox OFED
RUN cd / && \
    tar -xf /summit_rpm.tar.gz && \
    cd /summit_rpm/mellanox && \
    ./mlnxofedinstall -vvv --force --all --user-space-only --distro rhel7.4alternate --without-fw-update --without-openmpi \
                      --without-mlnxofed-docs --without-mpitests_openmpi --without-mpi-selector --without-ibsim \
                      --without-infiniband-diags --without-infiniband-diags-compat --without-perftest --without-mstflint \
                      --without-mft && \
    cd /summit_rpm && \
    export IBM_SPECTRUM_MPI_LICENSE_ACCEPT=yes && \
    yum -y --nogpgcheck localinstall /summit_rpm/ibm_smpi_lic_s-10.02.00dev0-rh7_20171107.ppc64le.rpm \
                                     /summit_rpm/ibm_smpi-10.02.00.00prpq-rh7_20171117.ppc64le.rpm \
                                     /summit_rpm/ibm_smpi-pami_devel-10.02.00.00prpq-rh7_20171117.ppc64le.rpm \
                                     /summit_rpm/ibm_smpi-devel-10.02.00.00prpq-rh7_20171117.ppc64le.rpm && \
    rm -rf /summit_rpm* && \
    yum -y clean all && \
    rm -rf /var/cache/yum

RUN export PERL5LIB=. && \
    mkdir /cuda_install && \
    cd /cuda_install && \
    wget -q https://developer.nvidia.com/compute/cuda/9.1/Prod/local_installers/cuda-repo-rhel7-9-1-local-9.1.85-1.ppc64le && \
    mv ./cuda-repo-rhel7-9-1-local-9.1.85-1.ppc64le ./cuda-repo-rhel7-9-1-local-9.1.85-1.ppc64le.rpm && \
    rpm -i cuda-repo-rhel7-9-1-local-9.1.85-1.ppc64le.rpm && \
    yum clean all && \
    yum -y install cuda-toolkit-9-1 && \
    rpm -evv cuda-repo-rhel7-9-1-local-9.1.85-1.ppc64le && \
    yum -y clean all && \
    rm -rf /var/cache/yum && \
    cd / && \
    rm -rf /cuda_install