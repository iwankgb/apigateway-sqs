#!/bin/bash
source api-env.sh
aws iam delete-policy --policy-arn $POLICY_ARN
aws iam delete-user --user-name apigateway-services
aws sqs delete-queue --queue-url $SQS_URL
