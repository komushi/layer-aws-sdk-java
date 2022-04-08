#!/bin/bash

source ./config.sh

DOCKERHUBREPO="${DOCKER_HUB_USER}/${LAYER_NAME}-builder-${JAVA_VERSION}"

docker build -t $DOCKERHUBREPO:$AWS_SDK2_VERSION .

docker push $DOCKERHUBREPO:$AWS_SDK2_VERSION