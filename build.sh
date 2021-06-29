#!/bin/bash

source ./config.sh
rm -rf $LAYER_NAME-$AWS_SDK2_VERSION.zip
docker build -t $LAYER_NAME:$AWS_SDK2_VERSION -t $LAYER_NAME:$latest .
docker run $LAYER_NAME:$AWS_SDK2_VERSION cat /tmp/layer.zip > $LAYER_NAME-$AWS_SDK2_VERSION.zip