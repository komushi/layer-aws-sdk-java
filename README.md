# lambda-layer-aws-sdk-java-v2
This repo generate an builder as docker image to create aws-sdk-java(v2) as lambda layer zip files. The layer zip includes specified AWS service modules.

## 0. Prerequisites
* docker cli
* aws cli

## 1. Edit/Confirm config.sh first

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
$ docker run komushi/aws-sdk-java-builder-java11:2.17.152 cat /tmp/layer.zip > aws-sdk-java-2.17.152.zip
```


# Dockerfile reference
## How to build from source
https://github.com/aws/aws-sdk-java-v2#building-from-source

## How to find specific modules
https://github.com/aws/aws-sdk-java-v2/tree/master/services