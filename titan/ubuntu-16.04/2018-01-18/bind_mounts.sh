#!/bin/bash

# Print commands executed
set -x

# Mount point for Cray files
mkdir -p /opt/cray

# Mount point for Cray files needed for ALPS runtime
mkdir -p /var/spool/alps
mkdir -p /var/opt/cray

# Mount point for lustre
mkdir -p /lustre/atlas
mkdir -p /lustre/atlas1
mkdir -p /lustre/atlas2

# Mount point for /sw
mkdir -p /sw
mkdir -p /ccs/sw
mkdir -p /autofs/nccs-svm1_sw

# Mount point for proj read-only dirs
mkdir -p /ccs/proj
mkdir -p /autofs/nccs-svm1_proj

# hugepage support
mkdir -p /var/lib/hugetlbfs

# Legacy init script mount
mkdir -p /.singularity.d/env
touch /.singularity.d/env/98-OLCF.sh