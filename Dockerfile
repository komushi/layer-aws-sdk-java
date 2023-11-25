ARG JAVA_VERSION="java11"

FROM lambci/lambda:build-${JAVA_VERSION}

COPY ./layer.zip /tmp/