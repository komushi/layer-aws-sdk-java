#!/bin/bash

MODULES="iot ecr ec2 sts cloudformation greengrass lambda iam cloudwatchlogs secretsmanager"
AWS_SDK2_VERSION="2.16.91"
LAYER_NAME="aws-sdk-java"
REGIONS="ap-southeast-1 ap-northeast-1"
BUCKET="gocheckin-lambda-layers"