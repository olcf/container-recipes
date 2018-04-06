FROM olcf/titan:ubuntu-16.04_2018-01-18

ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH:-}:/usr/local/cuda/lib:/usr/local/cuda/lib64
ENV PATH=${PATH:-}:/usr/local/cuda/bin:/usr/lib/jvm/jdk1.8.0_152/bin/:/usr/local/bin
ENV JAVA_HOME=/usr/lib/jvm/jdk1.8.0_152

RUN apt update && \
    apt-get install -y software-properties-common && \
    apt-add-repository universe && \
    apt update && \
    apt install -y mpich && \
    apt install -y build-essential wget curl pkg-config libtool autoconf g++ zip zlib1g-dev unzip git && \
    apt install -y python-numpy python-scipy python-dev python-pip python-setuptools && \
    apt install -y python3-numpy python3-scipy python3-dev python3-pip python3-setuptools && \
    rm -rf /var/lib/apt/lists/*

RUN wget http://ftp.osuosl.org/pub/funtoo/distfiles/oracle-java/jdk-8u152-linux-x64.tar.gz && \
    tar xf jdk-8u152-linux-x64.tar.gz && \
    mkdir -p /usr/lib/jvm && \
    mv jdk1.8.0_152 /usr/lib/jvm && \
    rm -rf jdk-8u152-linux-x64.tar.gz

RUN pip2 install --upgrade pip && \
    pip3 install --upgrade pip && \
    pip2 install setuptools --upgrade && \
    pip3 install setuptools --upgrade && \
    pip2 install --upgrade wheel && \
    pip3 install --upgrade wheel

RUN wget http://developer.download.nvidia.com/compute/redist/cudnn/v6.0/cudnn-7.5-linux-x64-v6.0.tgz && \
    tar xvzf cudnn-7.5-linux-x64-v6.0.tgz && \
    cp -P cuda/include/cudnn.h /usr/local/cuda/include && \
    cp -P cuda/lib64/libcudnn* /usr/local/cuda/lib64 && \
    chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn* && \
    rm -rf cudnn-7.5-linux-x64-v6.0.tgz && \
    rm -rf cuda

RUN cd / && \
    wget https://github.com/bazelbuild/bazel/releases/download/0.4.5/bazel-0.4.5-dist.zip && \
    unzip bazel-0.4.5-dist.zip -d /bazel && \
    cd bazel && \
    ./compile.sh && \
    cd output && \
    cp /bazel/output/bazel /usr/local/bin && \
    rm -rf /bazel-0.4.5-dist.zip

RUN export PYTHON_BIN_PATH=`which python` && \
    export PYTHON_LIB_PATH=/usr/lib/python2.7/dist-packages && \
    export TF_NEED_MKL=0 && \
    export CC_OPT_FLAGS="-march=native" && \
    export TF_NEED_JEMALLOC=1 && \
    export TF_NEED_GCP=0 && \
    export TF_NEED_HDFS=0 && \
    export TF_ENABLE_XLA=0 && \
    export TF_NEED_OPENCL=0 && \
    export TF_NEED_CUDA=1 && \
    export TF_CUDA_CLANG=0 && \
    export TF_CUDA_VERSION="7.5" && \
    export CUDA_TOOLKIT_PATH="/usr/local/cuda" && \
    export TF_CUDNN_VERSION="6" && \
    export CUDNN_INSTALL_PATH=$CUDA_TOOLKIT_PATH && \
    export TF_CUDA_COMPUTE_CAPABILITIES="3.5" && \
    export TF_NEED_VERBS=0 && \
    export TF_NEED_S3=0 && \
    export TF_NEED_GDR=0 && \
    export TF_NEED_OPENCL_SYCL=0 && \
    export GCC_HOST_COMPILER_PATH=/usr/bin/gcc-4.9 && \
    export TF_NEED_MPI=0 && \
    export LD_LIBRARY_PATH=/usr/local/cuda/lib64/stubs:$LD_LIBRARY_PATH && \
    ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1 && \
    cd / && \
    wget https://github.com/tensorflow/tensorflow/archive/v1.3.1.tar.gz && \
    tar xf v1.3.1.tar.gz && \
    cd tensorflow-1.3.1 && \
    ./configure && \
    bazel build --local_resources 2048,2.0,1.0 -c opt --copt=-mavx --copt=-msse4.1 --copt=-msse4.2 --config=cuda tensorflow/tools/pip_package:build_pip_package && \
    bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg && \
    pip2 install /tmp/tensorflow_pkg/tensorflow-*.whl && \
    cd / && \
    rm -rf /v1.3.1.tar.gz && \
    rm -rf /tensorflow-1.3.1 && \
    rm -rf /tmp/tensorflow_pkg

RUN export PYTHON_BIN_PATH=`which python3` && \
    export PYTHON_LIB_PATH=/usr/lib/python3/dist-packages && \
    export TF_NEED_MKL=0 && \
    export CC_OPT_FLAGS="-march=native" && \
    export TF_NEED_JEMALLOC=1 && \
    export TF_NEED_GCP=0 && \
    export TF_NEED_HDFS=0 && \
    export TF_ENABLE_XLA=0 && \
    export TF_NEED_OPENCL=0 && \
    export TF_NEED_CUDA=1 && \
    export TF_CUDA_CLANG=0 && \
    export TF_CUDA_VERSION="7.5" && \
    export CUDA_TOOLKIT_PATH="/usr/local/cuda" && \
    export TF_CUDNN_VERSION="6" && \
    export CUDNN_INSTALL_PATH=$CUDA_TOOLKIT_PATH && \
    export TF_CUDA_COMPUTE_CAPABILITIES="3.5" && \
    export TF_NEED_VERBS=0 && \
    export TF_NEED_S3=0 && \
    export TF_NEED_GDR=0 && \
    export TF_NEED_OPENCL_SYCL=0 && \
    export GCC_HOST_COMPILER_PATH=/usr/bin/gcc-4.9 && \
    export TF_NEED_MPI=0 && \
    export LD_LIBRARY_PATH=/usr/local/cuda/lib64/stubs:$LD_LIBRARY_PATH && \
    cd / && \
    wget https://github.com/tensorflow/tensorflow/archive/v1.3.1.tar.gz && \
    tar xf v1.3.1.tar.gz && \
    cd tensorflow-1.3.1 && \
    ./configure && \
    bazel build --local_resources 2048,2.0,1.0 -c opt --copt=-mavx --copt=-msse4.1 --copt=-msse4.2 --config=cuda tensorflow/tools/pip_package:build_pip_package && \
    bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg && \
    pip3 install /tmp/tensorflow_pkg/tensorflow-*.whl && \
    cd / && \
    rm -rf /v1.3.1.tar.gz && \
    rm -rf /tensorflow-1.3.1 && \
    rm -rf /tmp/tensorflow_pkg

# Make sure bazel is shutdown so it doesn't stop singularity from cleanly exiting
RUN bazel shutdown && \
    sleep 10 && \
    ps aux | grep bazel && \
    bazel shutdown && \
    sleep 60
