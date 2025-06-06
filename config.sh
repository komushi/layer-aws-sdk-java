#!/bin/bash

# MODULES="iot ecr ec2 sts cloudformation greengrass lambda iam cloudwatchlogs secretsmanager"
# AWS_SDK2_VERSION="2.16.104"
# JAVA_VERSION="java8"

MODULES="sqs s3 iotdataplane iot ecr ec2 sts cloudformation greengrass lambda iam cloudwatchlogs secretsmanager"
AWS_SDK2_VERSION="2.21.29"
JAVA_VERSION="java11"

LAYER_NAME="aws-sdk-java"
REGIONS="ap-northeast-1"
BUCKET="gocheckin-lambda-layer"
DOCKER_HUB_USER="komushi"