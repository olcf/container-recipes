#!/bin/bash

set -e

# This script lives one directory below the top level container-recipes directory
TOP_DIR=$(cd `dirname $0`/.. && pwd)

GIT_TOKEN=$(cat /gitlab-registry-token)

# System directories in which to look for builds in
SYSTEMS=(titan summitdev)

# A string containing all of the tags which is prepended to the README to allow the mirror to show what images are available
# This string is built up as the directory tree is traversed and containers are pushed to the registry
REGISTRY_LIST="# Images\n"

# Loop through directory struction container-recipes/{SYSTEM}/{DISTRO}/{TAG} and build docker image
for SYSTEM in "${SYSTEMS[@]}" ; do
    SYSTEM_DIR=${TOP_DIR}/${SYSTEM}
    REGISTRY_LIST=${REGISTRY_LIST}"\n## ${SYSTEM}\n"

    for DISTRO_DIR in $SYSTEM_DIR/*/ ; do
        DISTRO=$(basename ${DISTRO_DIR})
        REGISTRY_LIST=${REGISTRY_LIST}"- ${DISTRO}\n"

        for TAG_DIR in $DISTRO_DIR/*/ ; do
            cd ${TAG_DIR}
            TAG=$(basename ${TAG_DIR})
            FULL_TAG="code.ornl.gov:4567/olcf/container-recipes/${SYSTEM}/${DISTRO}:${TAG}"

            # There is a finite token lifetime and so we refresh it before every push
            docker login code.ornl.gov:4567 -u atj -p ${GIT_TOKEN}
            docker push ${FULL_TAG}

            REGISTRY_LIST=${REGISTRY_LIST}"  - ${TAG}\n"
        done
    done
done

# Provide git user information required for commit
git config --global user.email "atj@ornl.gov"
git config --global user.name "atj"

# Update registry list markdown
echo -e "${REGISTRY_LIST}" > ${TOP_DIR}/REGISTRY_LIST.md
git checkout -B master origin/master
git add ${TOP_DIR}/REGISTRY_LIST.md
git commit -m "Updating registry list"
git push https://atj:${GIT_TOKEN}@code.ornl.gov/olcf/container-recipes master