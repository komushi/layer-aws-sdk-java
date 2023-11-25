#!/bin/bash

source ./config.sh

curl -SL https://github.com/aws/aws-sdk-java-v2/archive/refs/tags/$AWS_SDK2_VERSION.tar.gz | tar -zxC ./ && \
cd ./aws-sdk-java-v2-$AWS_SDK2_VERSION && \
for MODULE in $MODULES; do mvn clean install -Dmaven.javadoc.skip=true -pl :$MODULE -P quick --am ; done && \
cd ../ && \
mkdir -p ./opt/java/lib && \
for MODULE in $MODULES; do cp ./aws-sdk-java-v2-$AWS_SDK2_VERSION/services/$MODULE/target/aws-sdk-java-$MODULE-$AWS_SDK2_VERSION.jar ./opt/java/lib ; done && \
cd ./opt/ && \
zip -yr ../layer.zip ./* && \
cd ../ && \
rm -rf ./aws-sdk-java-v2-$AWS_SDK2_VERSION/ && \
rm -rf ./opt/

DOCKERHUBREPO="${DOCKER_HUB_USER}/${LAYER_NAME}-builder-${JAVA_VERSION}"

docker build -t $DOCKERHUBREPO:$AWS_SDK2_VERSION .

docker push $DOCKERHUBREPO:$AWS_SDK2_VERSION