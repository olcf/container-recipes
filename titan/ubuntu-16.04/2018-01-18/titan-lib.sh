#!/usr/bin/env bash

# The following script will create titan_lib.tar.gz container all titan specific libraries

rm -rf ./titan_lib.tar.gz
rm -rf ./titan_lib

mkdir ./titan_lib

cp --preserve=links /opt/cray/mpt/7.6.3/gni/mpich-gnu/4.9/lib/*.so*           ./titan_lib

cp --preserve=links /opt/cray/sysutils/1.0-1.0502.60492.1.1.gem/lib64/*.so*   ./titan_lib
cp --preserve=links /opt/cray/wlm_detect/1.0-1.0502.64649.2.2.gem/lib64/*.so* ./titan_lib
cp --preserve=links /opt/cray/xpmem/0.1-2.0502.64982.5.3.gem/lib64/*.so*      ./titan_lib
cp --preserve=links /opt/cray/ugni/6.0-1.0502.10863.8.28.gem/lib64/*.so*      ./titan_lib
cp --preserve=links /opt/cray/udreg/2.3.2-1.0502.10518.2.17.gem/lib64/*.so*   ./titan_lib
cp --preserve=links /opt/cray/pmi/5.0.12/lib64/*.so*                          ./titan_lib
cp --preserve=links /opt/cray/alps/5.2.4-2.0502.9950.37.1.gem/lib64/*.so*     ./titan_lib

cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/libcuda.so.352.101            ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/libEGL.so.352.101             ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/libGLESv1_CM.so.352.101       ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/libGLESv2.so.352.101          ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/libGL.so.352.101              ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/libglx.so.352.101             ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/libnvcuvid.so.352.101         ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/libnvidia-cfg.so.352.101      ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/libnvidia-compiler.so.352.101 ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/libnvidia-eglcore.so.352.101  ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/libnvidia-encode.so.352.101   ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/libnvidia-fbc.so.352.101      ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/libnvidia-glcore.so.352.101   ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/libnvidia-glsi.so.352.101     ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/libnvidia-ifr.so.352.101      ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/libnvidia-ml.so.352.101       ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/libnvidia-tls.so.352.101      ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/libnvidia-wfb.so.352.101      ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/libOpenCL.so.1.0.0            ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/libnvidia-opencl.so.352.101   ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/libvdpau_nvidia.so.352.101    ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/nvidia_drv.so                 ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/tls_test_dso.so               ./titan_lib
cp /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/tls/libnvidia-tls.so.352.101  ./titan_lib

tar -zcvf ./titan_lib.tar.gz ./titan_lib
rm -rf ./titan_lib