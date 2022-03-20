#!/bin/bash

source ./config.sh

DESCRIPTION="AWS_SDK_JAVA ${AWS_SDK2_VERSION}"
FILENAME=${LAYER_NAME}-${AWS_SDK2_VERSION}
DOCKERHUBREPO="komushi/${LAYER_NAME}-layer-builder"

docker run $DOCKERHUBREPO:$AWS_SDK2_VERSION cat /tmp/layer.zip > $FILENAME.zip

aws s3api create-bucket --bucket ${BUCKET} --create-bucket-configuration LocationConstraint=ap-southeast-1

aws s3api put-object --bucket ${BUCKET} --key layers/${FILENAME} --body ${FILENAME}.zip

for REGION in $REGIONS; do
  aws s3api create-bucket --bucket ${BUCKET}-${REGION} --region $REGION --create-bucket-configuration LocationConstraint=$REGION
done

for REGION in $REGIONS; do
  aws s3api copy-object --region $REGION --copy-source ${BUCKET}/layers/${FILENAME} \
    --bucket ${BUCKET}-${REGION} --key layers/${FILENAME} && \
  aws lambda add-layer-version-permission --region $REGION --layer-name $LAYER_NAME \
    --statement-id sid1 --action lambda:GetLayerVersion --principal '*' \
    --version-number $(aws lambda publish-layer-version --region $REGION --layer-name $LAYER_NAME \
      --content S3Bucket=${BUCKET}-${REGION},S3Key=layers/${FILENAME} \
      --compatible-runtimes "java8" \
      --description "$DESCRIPTION" --query Version --output text) &
done

for job in $(jobs -p); do
  wait $job
done