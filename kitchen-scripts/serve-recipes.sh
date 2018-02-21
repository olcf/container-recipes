#!/bin/bash

set -e

# This script lives one directory below the top level container-recipes directory
TOP_DIR=$(cd `dirname $0`/.. && pwd)


# Login to dockerhub and gitlab
docker login code.ornl.gov:4567 -u ${GITLAB_ADMIN_USERNAME} -p ${GITLAB_ADMIN_TOKEN}
docker login -u ${DOCKERHUB_ADMIN_USERNAME} -p ${DOCKERHUB_ADMIN_TOKEN}

# Push all images to gitlab and dockerhub
for IMAGE in $(docker images --filter "label=OLCF" --format "{{.Repository}}:{{.Tag}}") ; do
    echo pushing ${IMAGE}

    docker push ${IMAGE}
done