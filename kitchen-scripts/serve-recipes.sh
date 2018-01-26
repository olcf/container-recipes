#!/bin/bash

set -e

# This script lives one directory below the top level container-recipes directory
TOP_DIR=$(cd `dirname $0`/.. && pwd)

GITLAB_USERNAME=$(cat /gitlab-username)
GITLAB_ADMIN_TOKEN=$(cat /gitlab-admin-token)
DOCKERHUB_ADMIN_USERNAME=$(cat /dockerhub-admin-username)
DOCKERHUB_ADMIN_TOKEN=$(cat /dockerhub-admin-token)

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

            # Push to gitlab
            GITLAB_IMAGE="code.ornl.gov:4567/olcf/container-recipes/${SYSTEM}/${DISTRO}:${TAG}"
            docker login code.ornl.gov:4567 -u ${GITLAB_USERNAME} -p ${GITLAB_ADMIN_TOKEN}
            docker push ${GITLAB_IMAGE}

            # Push to dockerhub
            DOCKERHUB_IMAGE="olcf/${SYSTEM}:${DISTRO}_${TAG}"
            docker login -u ${DOCKERHUB_ADMIN_USERNAME} -p ${DOCKERHUB_ADMIN_TOKEN}
            docker push ${DOCKERHUB_IMAGE}

            REGISTRY_LIST=${REGISTRY_LIST}"  - ${GITLAB_IMAGE}\n"
            REGISTRY_LIST=${REGISTRY_LIST}"  - ${DOCKERHUB_IMAGE}\n"
        done
    done
done

# Provide git user information required for commit
git config --global user.email "${GITLAB_USERNAME}@ornl.gov"
git config --global user.name ${GITLAB_USERNAME}

# Update registry list markdown
echo -e "${REGISTRY_LIST}" > ${TOP_DIR}/REGISTRY_LIST.md
git checkout -B master origin/master
git add ${TOP_DIR}/REGISTRY_LIST.md
git diff-index --quiet HEAD || git commit -m "Updating registry list"
git push https://${GITLAB_USERNAME}:${GITLAB_ADMIN_TOKEN}@code.ornl.gov/olcf/container-recipes master