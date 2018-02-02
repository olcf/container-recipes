FROM centos:7

COPY titan_lib.tar.gz /titan_lib.tar.gz
COPY bind_mounts.sh /bind_mounts.sh

ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH:-}:/usr/local/cuda/lib:/usr/local/cuda/lib64
ENV PATH=${PATH:-}:/usr/local/cuda/bin:/usr/lib64/mpich/bin

RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install wget gcc-c++ gcc-gfortran redhat-lsb mpich mpich-devel glibc-static cmake libstdc++-static numactl libhugetlbfs && \
    yum -y clean all && \
    rm -rf /var/cache/yum

RUN wget -q http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda_7.5.18_linux.run && \
    export PERL5LIB=. && \
    sh cuda_7.5.18_linux.run --silent --toolkit --override && \
    rm -rf cuda_7.5.18_linux.run

RUN ./bind_mounts.sh && \
    rm /bind_mounts.sh

RUN tar -xf /titan_lib.tar.gz && \
    rm /titan_lib.tar.gz

RUN wget https://nixos.org/releases/patchelf/patchelf-0.9/patchelf-0.9.tar.gz && \
    tar xf patchelf-0.9.tar.gz && \
    cd patchelf-0.9 && \
    ./configure && \
    make && \
    make install && \
    rm -rf patchelf-0.9.tar.gz patchelf-0.9

RUN patchelf --set-rpath /titan_lib /titan_lib/libmpich_gnu_49.so.3.0.1
RUN patchelf --set-rpath /titan_lib /titan_lib/libmpichcxx_gnu_49.so.3.0.1
RUN patchelf --set-rpath /titan_lib /titan_lib/libfmpich_gnu_49.so.3.0.1

RUN cp /titan_lib/libmpich_gnu_49.so.3.0.1 /usr/lib64/mpich/lib/libmpich.so.10.0.4 && \
    cp /titan_lib/libmpichcxx_gnu_49.so.3.0.1 /usr/lib64/mpich/lib/libmpichcxx.so.10.0.4 && \
    cp /titan_lib/libfmpich_gnu_49.so.3.0.1 /usr/lib64/mpich/lib/libmpichf90.so.10.0.4 && \
    cp /titan_lib/libfmpich_gnu_49.so.3.0.1 /usr/lib64/mpich/lib/libfmpich.so.10.0.4

RUN wget https://github.com/AdamSimpson/set_pid/archive/0.1.tar.gz && \
    tar xf 0.1.tar.gz && \
    cd set_pid-0.1 && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make && make install