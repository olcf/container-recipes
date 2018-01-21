#!/bin/bash

set -e
set -o xtrace

apt-get -y update
apt-get -y install expect
apt-get -y install yum rpm

# Install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) edge"
apt-get update
apt-get install -y docker-ce

#####################################
# begin ppc64le QUEMU stuff
######################################

# Add support of ppc64le arch
apt-get install -y qemu binfmt-support zlib1g-dev libglib2.0-dev libpixman-1-dev libfdt-dev libpython2.7-stdlib

# Install a newer qemu from source to support ppc64le
wget -q 'https://download.qemu.org/qemu-2.11.0.tar.xz'
tar xvJf qemu-2.11.0.tar.xz
cd qemu-2.11.0
mkdir build
cd build
../configure --static --target-list=ppc64le-linux-user
make
make install

# A dirty hack to copy the custom qemu static binary(ies) over top of the distro provided dynamically linked binaries
cp -r /usr/local/bin/qemu-* /usr/bin

#####################################
# End ppc64le
#####################################

# fix yum/RPM issue under debian: https://github.com/singularityware/singularity/issues/241
cat << EOF > /root/.rpmmacros
%_var /var
%_dbpath %{_var}/lib/rpm
EOF

# Install Singularity
cd /
export VERSION=2.4
wget -q https://github.com/singularityware/singularity/releases/download/${VERSION}/singularity-${VERSION}.tar.gz
tar xvf singularity-${VERSION}.tar.gz
cd singularity-${VERSION}
./configure --prefix=/usr/local
make
make install

# Install Gitlab CI runner
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
cat > /etc/apt/preferences.d/pin-gitlab-runner.pref <<EOF
Explanation: Prefer GitLab provided packages over the Debian native ones
Package: gitlab-runner
Pin: origin packages.gitlab.com
Pin-Priority: 1001
EOF
sudo apt-get install gitlab-runner

# Allow the gitlab-runner user to run docker
usermod -aG docker gitlab-runner