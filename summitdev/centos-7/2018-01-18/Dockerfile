FROM ppc64le/centos:7

ADD https://code.ornl.gov/olcf/container-recipes/raw/master/summitdev/qemu-ppc64le /usr/bin/qemu-ppc64le
COPY summitdev_rpm.tar.gz /summitdev_rpm.tar.gz

ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH-}:/usr/local/cuda/lib:/usr/local/cuda/lib64:/opt/ibm/spectrum_mpi/lib
ENV PATH=${PATH-}:/usr/local/cuda/bin:/usr/lib64/mpich/bin:/opt/ibm/spectrum_mpi/bin

RUN yum -y update && \
    yum -y install epel-release && \
    yum -y update && \
    yum -y install wget gcc-c++ gcc-gfortran redhat-lsb mpich mpich-devel python-devel python-pip python-setuptools \
         python34 python34-devel python34-pip python34-setuptools glibc-static libstdc++-static numactl

# Install Spectrum MPI
RUN cd / && \
    tar -xf /summitdev_rpm.tar.gz && \
    rm /summitdev_rpm.tar.gz && \
    export IBM_SPECTRUM_MPI_LICENSE_ACCEPT=yes && \
    yum -y --nogpgcheck localinstall /summitdev_rpm/ibm_smpi-10.1.0.4-rh7.ppc64le.rpm \
                                     /summitdev_rpm/ibm_smpi_lic_s-10.1-rh7.ppc64le.rpm && \
    rm -rf /summitdev_rpm

RUN pip2 install --upgrade pip && \
    pip3 install --upgrade pip && \
    pip2 install setuptools --upgrade && \
    pip3 install setuptools --upgrade && \
    pip2 install --upgrade wheel && \
    pip3 install --upgrade wheel && \
    pip2 install mpi4py && \
    pip3 install mpi4py

# Install Cuda 9.0
RUN export PERL5LIB=. && \
    wget -q https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda-repo-rhel7-9-0-local-9.0.176-1.ppc64le-rpm && \
    rpm -i cuda-repo-rhel7-9-0-local-9.0.176-1.ppc64le-rpm && \
    yum -y clean all && \
    yum -y install cuda-toolkit-9-0

# Install cuDNN
RUN wget -q http://developer.download.nvidia.com/compute/redist/cudnn/v7.0.3/cudnn-9.0-linux-ppc64le-v7.tgz && \
    tar xvzf cudnn-9.0-linux-ppc64le-v7.tgz && \
    cp -P cuda/targets/ppc64le-linux/include/cudnn.h /usr/local/cuda/include && \
    cp -P cuda/targets/ppc64le-linux/lib/libcudnn* /usr/local/cuda/lib64 && \
    chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*

# Clean up CUDA install
RUN rm -rf cuda-repo-rhel7-9-0-local-9.0.176-1.ppc64le-rpm && \
    rm -rf cudnn-9.0-linux-ppc64le-v7.tgz

# Create bind mount paths
RUN wget -q https://code.ornl.gov/olcf/container-recipes/blob/master/titan/BindMounts.sh && \
    ./BindMounts.sh