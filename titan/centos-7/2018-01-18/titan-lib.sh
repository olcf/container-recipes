#!/usr/bin/env bash

# The following script will create titan_lib.tar.gz container all titan specific libraries

rm -rf ./titan_lib.tar.gz
rm -rf ./titan_lib

mkdir ./titan_lib

cp /opt/cray/mpt/7.6.3/gni/mpich-gnu/4.9/lib/*.so*           ./titan_lib

cp /opt/cray/sysutils/1.0-1.0502.60492.1.1.gem/lib64/*.so*   ./titan_lib
cp /opt/cray/wlm_detect/1.0-1.0502.64649.2.2.gem/lib64/*.so* ./titan_lib
cp /opt/cray/xpmem/0.1-2.0502.64982.5.3.gem/lib64/*.so*      ./titan_lib
cp /opt/cray/ugni/6.0-1.0502.10863.8.28.gem/lib64/*.so*      ./titan_lib
cp /opt/cray/udreg/2.3.2-1.0502.10518.2.17.gem/lib64/*.so*   ./titan_lib
cp /opt/cray/pmi/5.0.12/lib64/*.so*                          ./titan_lib
cp /opt/cray/alps/5.2.4-2.0502.9950.37.1.gem/lib64/*.so*     ./titan_lib

cp -r /opt/cray/nvidia/352.101-1_1.0502.2465.0.0.gem/lib64/* ./titan_lib

tar -zcvf ./titan_lib.tar.gz ./titan_lib
rm -rf ./titan_lib