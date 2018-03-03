FROM ppc64le/centos:7

COPY qemu-ppc64le-static /usr/bin/qemu-ppc64le-static
COPY summit-packages.tar.gz /summit-packages.tar.gz

ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH:-}:/usr/local/cuda/lib:/usr/local/cuda/lib64:/opt/ibm/spectrum_mpi/lib:/opt/ibm/spectrum_mpi/lib/spectrum_mpi
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
                   perl numactl-libs tcsh libnl tcl tk strace && \
    yum -y clean all && \
    rm -rf /var/cache/yum

# Install Mellanox OFED, SMPI, and CSM
RUN cd / && \
    tar -xf /summit-packages.tar.gz && \
    cd /summit-packages/mellanox && \
    ./mlnxofedinstall -vvv --force --all --user-space-only --distro rhel7.4alternate --without-fw-update --without-openmpi \
                      --without-mlnxofed-docs --without-mpitests_openmpi --without-mpi-selector --without-ibsim \
                      --without-infiniband-diags-compat --without-opensm --without-perftest --without-mstflint --without-mft && \
    cd /summit-packages/smpi && \
    export IBM_SPECTRUM_MPI_LICENSE_ACCEPT=yes && \
    yum -y --nogpgcheck localinstall *.rpm  && \
    cd / && \
    rm -rf /summit-packages && \
    yum -y clean all && \
    rm -rf /var/cache/yum

# Install CUDA toolkit components
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

# jsrun modifies the LD_LIBRARY_PATH and LD_PRELOAD, which are blown away by singularity due to setuid security concerns
# Additionally /etc/ld.so.conf.d/hcoll.conf and /etc/ld.so.conf.d/jsm.conf are missing for some reason in the container install and so their entries are manually added to LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH:-}:/opt/ibm/spectrum_mpi/jsm_pmix/lib:/opt/ibm/spectrum_mpi/lib/pami_port:/opt/mellanox/hcoll/lib
ENV LD_PRELOAD=/opt/ibm/spectrum_mpi/lib/libpami_cudahook.so