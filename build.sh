#!/bin/bash

source ./modules.sh
docker build -t layer-aws-sdk-java-v2: .
aws-sdk-java-v2-layer-$AWS_SDK2_VERSION.zip
docker run layer-aws-sdk-java-v2 cat /tmp/aws-sdk-java-v2-layer.zip > aws-sdk-java-v2-layer-$AWS_SDK2_VERSION.zip