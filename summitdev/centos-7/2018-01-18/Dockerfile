FROM ppc64le/centos:7

COPY qemu-ppc64le /usr/bin/qemu-ppc64le
COPY summitdev_rpm.tar.gz /summitdev_rpm.tar.gz

ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH:-}:/usr/local/cuda/lib:/usr/local/cuda/lib64:/opt/ibm/spectrum_mpi/lib
ENV PATH=${PATH:-}:/usr/local/cuda/bin:/usr/lib64/mpich/bin:/opt/ibm/spectrum_mpi/bin

RUN yum -y update && \
    yum -y install epel-release && \
    yum -y update && \
    yum -y install wget gcc-c++ gcc-gfortran redhat-lsb mpich mpich-devel python-devel python-pip python-setuptools \
         python34 python34-devel python34-pip python34-setuptools glibc-static libstdc++-static numactl && \
    yum -y clean all

# Install Spectrum MPI
RUN cd / && \
    tar -xf /summitdev_rpm.tar.gz && \
    rm /summitdev_rpm.tar.gz && \
    export IBM_SPECTRUM_MPI_LICENSE_ACCEPT=yes && \
    yum -y --nogpgcheck localinstall /summitdev_rpm/ibm_smpi-10.1.0.4-rh7.ppc64le.rpm \
                                     /summitdev_rpm/ibm_smpi_lic_s-10.1-rh7.ppc64le.rpm && \
    rm -rf /summitdev_rpm

# Install mpi4py
RUN pip2 --no-cache-dir install --upgrade pip && \
    pip3 --no-cache-dir install --upgrade pip && \
    pip2 --no-cache-dir install setuptools --upgrade && \
    pip3 --no-cache-dir install setuptools --upgrade && \
    pip2 --no-cache-dir install --upgrade wheel && \
    pip3 --no-cache-dir install --upgrade wheel && \
    pip2 --no-cache-dir install mpi4py && \
    pip3 --no-cache-dir install mpi4py

# Install CUDA
RUN export PERL5LIB=. && \
    wget -q https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda-repo-rhel7-9-0-local-9.0.176-1.ppc64le-rpm && \
    rpm -i cuda-repo-rhel7-9-0-local-9.0.176-1.ppc64le-rpm && \
    yum -y install cuda-toolkit-9-0 && \
    yum -y clean all && \
    rm -rf cuda-repo-rhel7-9-0-local-9.0.176-1.ppc64le-rpm

# Install cuDNN
RUN wget -q http://developer.download.nvidia.com/compute/redist/cudnn/v7.0.3/cudnn-9.0-linux-ppc64le-v7.tgz && \
    tar xvzf cudnn-9.0-linux-ppc64le-v7.tgz && \
    cp -P cuda/targets/ppc64le-linux/include/cudnn.h /usr/local/cuda/include && \
    cp -P cuda/targets/ppc64le-linux/lib/libcudnn* /usr/local/cuda/lib64 && \
    chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn* && \
    rm -rf cudnn-9.0-linux-ppc64le-v7.tgz