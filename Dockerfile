FROM lambci/lambda:build-java8.al2
# FROM lambci/lambda:build-java8

COPY modules.sh /tmp/

ENV AWS_SDK2_VERSION 2.16.91

WORKDIR /tmp

RUN curl -SL https://github.com/aws/aws-sdk-java-v2/archive/refs/tags/$AWS_SDK2_VERSION.tar.gz | tar -zxC ./ && \
    cd /tmp/aws-sdk-java-v2-$AWS_SDK2_VERSION && \
    source modules.sh
    for MODULE in $MODULES; do echo "$MODULE" ; done

#    mvn clean install -pl :iot -P quick --am && \
#    mvn clean install -pl :ecr -P quick --am && \
#    mvn clean install -pl :ec2 -P quick --am && \
#    mvn clean install -pl :sts -P quick --am && \
#    mvn clean install -pl :cloudformation -P quick --am && \
#    mvn clean install -pl :iot -P quick --am && \
#    mvn clean install -pl :greengrass -P quick --am && \
#    mvn clean install -pl :lambda -P quick --am && \
#    mvn clean install -pl :iam -P quick --am && \
#    mvn clean install -pl :cloudwatchlogs -P quick --am && \
#    mvn clean install -pl :secretsmanager -P quick --am && \

#WORKDIR /opt

#RUN mkdir -p ./java/lib && \
#    cp /tmp/aws-sdk-java-v2-$AWS_SDK2_VERSION/services/iot/target/aws-sdk-java-iot-$AWS_SDK2_VERSION.jar ./java/lib && \
#    zip -yr /tmp/aws-sdk-java-v2-layer.zip ./*