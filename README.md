# lambda-layer-aws-sdk-java-v2
This repo generate an builder as docker image to create aws-sdk-java(v2) as lambda layer zip files. The layer zip includes specified AWS service modules.

## 0. Prerequisites
* docker cli
* aws cli
* create a base bucket in ap-southeast-1: gocheckin-lambda-layers

## 1. Edit/Confirm config.sh first
### 1-1. Option when iuse java11 and AWS_SDK2_VERSION >= 2.17.x
```
MODULES="iot ecr ec2 sts cloudformation greengrass lambda iam cloudwatchlogs secretsmanager"
AWS_SDK2_VERSION="2.21.29"
JAVA_VERSION="java11"
```

### 1-2. Option when iuse java8 and AWS_SDK2_VERSION >= 2.16.x
```
MODULES="iot ecr ec2 sts cloudformation greengrass lambda iam cloudwatchlogs secretsmanager"
AWS_SDK2_VERSION="2.16.104"
JAVA_VERSION="java8"
```

## 2. Publish lambda layer to AWS account

```
$ bash ./publish.sh
```

## 3. If publish.sh fails run build.sh first

```
$ bash ./build.sh
```

### 3-1. Test to export aws-sdk-java zip file

```
$ docker run komushi/aws-sdk-java-builder-java11:2.17.167 cat /tmp/layer.zip > aws-sdk-java-2.17.167.zip
```

# References
## How to build aws-sdk-java-v2 from source
https://github.com/aws/aws-sdk-java-v2#building-from-source

## How to find specific modules
https://github.com/aws/aws-sdk-java-v2/tree/master/services

## How to find aws-sdk-java-v2 versions
https://github.com/aws/aws-sdk-java-v2/tags

## How to find existing aws-sdk-java java8 images on docker hub
https://hub.docker.com/repository/docker/komushi/aws-sdk-java-builder-java8

## How to find existing aws-sdk-java java11 images on docker hub
https://hub.docker.com/repository/docker/komushi/aws-sdk-java-builder-java11