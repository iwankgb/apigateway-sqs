#!/bin/bash
SQS_URL=`aws sqs create-queue --queue-name apigateway --output text`
echo SQS_URL=$SQS_URL >api-env.sh
SQS_ARN=`aws sqs get-queue-attributes --queue-url "$SQS_URL" --output text --attribute-names QueueArn | awk '{ print $2 }'`
echo SQS_ARN=$SQS_ARN >>api-env.sh
sed s/SQS_ARN/$SQS_ARN/ sqs-policy-template.json >sqs-policy.json
USER_ARN=`aws iam create-user --user-name apigateway-services --output text | awk '{ print $2 }'`
echo USER_ARN=$USER_ARN >>api-env.sh
POLICY_ARN=`aws iam create-policy --policy-name apigateway-sqs-policy --policy-document file://sqs-policy.json --output text | awk '{ print $2 }'`
echo POLICY_ARN=$POLICY_ARN >>api-env.sh
cat api-env.sh

