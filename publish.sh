#!/bin/bash

source ./config.sh

DESCRIPTION="AWS_SDK_JAVA ${AWS_SDK2_VERSION}"
FILENAME=${LAYER_NAME}-${AWS_SDK2_VERSION}.zip

aws s3api put-object --bucket ${BUCKET} --key layers/${FILENAME} --body ${FILENAME}.zip

for REGION in $REGIONS; do
  aws s3api copy-object --region $REGION --copy-source ${BUCKET}/layers/${FILENAME} \
    --bucket lambci-${REGION} --key layers/${FILENAME} && \
  aws lambda add-layer-version-permission --region $REGION --layer-name $LAYER_NAME \
    --statement-id sid1 --action lambda:GetLayerVersion --principal '*' \
    --version-number $(aws lambda publish-layer-version --region $REGION --layer-name $LAYER_NAME \
      --content S3Bucket=${BUCKET}-${REGION},S3Key=layers/${FILENAME} \
      --description "$DESCRIPTION" --query Version --output text) &
done

for job in $(jobs -p); do
  wait $job
done