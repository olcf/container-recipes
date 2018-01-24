FROM ppc64le/centos:7

COPY qemu-ppc64le-static /usr/bin/qemu-ppc64le-static
COPY summitdev_rpm.tar.gz /summitdev_rpm.tar.gz

ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH:-}:/usr/local/cuda/lib:/usr/local/cuda/lib64:/opt/ibm/spectrum_mpi/lib
ENV PATH=${PATH:-}:/usr/local/cuda/bin:/usr/lib64/mpich/bin:/opt/ibm/spectrum_mpi/bin

RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install wget gcc-c++ gcc-gfortran redhat-lsb mpich mpich-devel glibc-static libstdc++-static numactl && \
    yum -y clean all && \
    rm -rf /var/cache/yum

RUN cd / && \
    tar -xf /summitdev_rpm.tar.gz && \
    rm /summitdev_rpm.tar.gz && \
    export IBM_SPECTRUM_MPI_LICENSE_ACCEPT=yes && \
    yum -y --nogpgcheck localinstall /summitdev_rpm/ibm_smpi-10.1.0.4-rh7.ppc64le.rpm \
                                     /summitdev_rpm/ibm_smpi_lic_s-10.1-rh7.ppc64le.rpm && \
    rm -rf /summitdev_rpm

RUN export PERL5LIB=. && \
    mkdir /cuda_install && \
    cd /cuda_install && \
    wget -q https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda-repo-rhel7-9-0-local-9.0.176-1.ppc64le-rpm && \
    rpm -i cuda-repo-rhel7-9-0-local-9.0.176-1.ppc64le-rpm && \
    yum -y install cuda-toolkit-9-0 && \
    rpm -evv cuda-repo-rhel7-9-0-local-9.0.176-1.ppc64le && \
    yum -y clean all && \
    rm -rf /var/cache/yum && \
    cd / && \
    rm -rf /cuda_install