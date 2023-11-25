ARG JAVA_VERSION="java11"

FROM lambci/lambda:build-${JAVA_VERSION}

COPY config.sh /tmp/

RUN source /tmp/config.sh && \
    cd /tmp/ && \
    curl -SL https://github.com/aws/aws-sdk-java-v2/archive/refs/tags/$AWS_SDK2_VERSION.tar.gz | tar -zxC ./ && \
    cd /tmp/aws-sdk-java-v2-$AWS_SDK2_VERSION && \
    for MODULE in $MODULES; do mvn clean install -Dmaven.javadoc.skip=true -pl :$MODULE -P quick --am ; done && \
    cd /opt/ && \
    mkdir -p /opt/java/lib && \
    for MODULE in $MODULES; do cp /tmp/aws-sdk-java-v2-$AWS_SDK2_VERSION/services/$MODULE/target/aws-sdk-java-$MODULE-$AWS_SDK2_VERSION.jar ./java/lib ; done && \
    zip -yr /tmp/layer.zip ./* && \
    rm -rf /tmp/aws-sdk-java-v2-$AWS_SDK2_VERSION/
