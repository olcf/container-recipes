FROM centos:7

COPY titan_lib.tar.gz /titan_lib.tar.gz

ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH-}/usr/local/cuda/lib:/usr/local/cuda/lib64
ENV PATH=${PATH-}:/usr/local/cuda/bin:/usr/lib64/mpich/bin

RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install wget gcc-c++ gcc-gfortran redhat-lsb mpich mpich-devel python-devel python-pip python-setuptools \
                   python34 python34-devel python34-pip python34-setuptools glibc-static libstdc++-static numactl

RUN wget -q http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda_7.5.18_linux.run && \
    export PERL5LIB=. && \
    sh cuda_7.5.18_linux.run --silent --toolkit --override && \
    rm cuda_7.5.18_linux.run

RUN pip2 install --upgrade pip && \
    pip3 install --upgrade pip && \
    pip2 install setuptools --upgrade && \
    pip3 install setuptools --upgrade && \
    pip2 install --upgrade wheel && \
    pip3 install --upgrade wheel && \
    pip2 install mpi4py && \
    pip3 install mpi4py

RUN wget -q https://code.ornl.gov/olcf/container-recipes/raw/master/Titan/BindMounts.sh && \
    sh /BindMounts.sh && \
    rm BindMounts.sh

RUN tar -xf /titan_lib.tar.gz && \
    rm /titan_lib.tar.gz

RUN cp /titan_lib/libmpich_gnu_49.so.3.0.1 /usr/lib64/mpich/lib/libmpich.so.10.0.4 && \
    cp /titan_lib/libmpichcxx_gnu_49.so.3.0.1 /usr/lib64/mpich/lib/libmpichcxx.so.10.0.4 && \
    cp /titan/lib/libfmpich_gnu_49.so.3.0.1 /usr/lib64/mpich/lib/libmpichf90.so.10.0.4 && \
    cp /titan/lib/libfmpich_gnu_49.so.3.0.1 /usr/lib64/mpich/lib/libfmpich.so.10.0.4

# Create bind mount paths
RUN wget -q https://code.ornl.gov/olcf/container-recipes/blob/master/titan/BindMounts.sh && \
    ./BindMounts.sh