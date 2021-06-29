#FROM lambci/lambda:build-java8.al2
FROM lambci/lambda:build-java8

COPY modules.sh /tmp/

WORKDIR /tmp

RUN source /tmp/modules.sh && \
    curl -SL https://github.com/aws/aws-sdk-java-v2/archive/refs/tags/$AWS_SDK2_VERSION.tar.gz | tar -zxC ./ && \
    cd /tmp/aws-sdk-java-v2-$AWS_SDK2_VERSION && \
    for MODULE in $MODULES; do mvn clean install -pl :$MODULE -P quick --am ; done

WORKDIR /opt

RUN source /tmp/modules.sh && \
    mkdir -p ./java/lib && \
    for MODULE in $MODULES; do cp /tmp/aws-sdk-java-v2-$AWS_SDK2_VERSION/services/$MODULE/target/aws-sdk-java-$MODULE-$AWS_SDK2_VERSION.jar ./java/lib ; done && \
    zip -yr /tmp/aws-sdk-java-v2-layer.zip ./* && \
    rm -rf /tmp/aws-sdk-java-v2-$AWS_SDK2_VERSION/
