#!/bin/bash

set -e

# This script lives one directory below the top level container-recipes directory
TOP_DIR=$(cd `dirname $0`/.. && pwd)

GITLAB_USERNAME=$(cat /gitlab-username)
GITLAB_ADMIN_TOKEN=$(cat /gitlab-admin-token)
DOCKERHUB_ADMIN_USERNAME=$(cat /dockerhub-admin-username)
DOCKERHUB_ADMIN_TOKEN=$(cat /dockerhub-admin-token)

# A string containing all of the tags which is prepended to the README to allow the mirror to show what images are available
# This string is built up as the directory tree is traversed and containers are pushed to the registry
REGISTRY_LIST="# Images\n"

# Login to dockerhub and gitlab
docker login code.ornl.gov:4567 -u ${GITLAB_USERNAME} -p ${GITLAB_ADMIN_TOKEN}
docker login -u ${DOCKERHUB_ADMIN_USERNAME} -p ${DOCKERHUB_ADMIN_TOKEN}

# Push all images to gitlab and dockerhub
for IMAGE in $(docker images --filter "label=OLCF" --format "{{.Repository}}:{{.Tag}}") ; do
    echo pushing ${IMAGE}

    docker push ${IMAGE}
    REGISTRY_LIST=${REGISTRY_LIST}"  - ${IMAGE}\n"
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