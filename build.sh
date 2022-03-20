#!/bin/bash

source ./config.sh

DOCKERHUBREPO="${DOCKER_HUB_USER}/${LAYER_NAME}-layer-builder"

docker build -t $DOCKERHUBREPO:$AWS_SDK2_VERSION .
