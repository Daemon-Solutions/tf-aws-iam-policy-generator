# tf-aws-iam-policy-generator

A module similar to tf-aws-iam-instance-profile for generating IAM policies for various different uses. e.g. policies for attaching to user, groups or roles. The purpose of this is to allow us to have well tested IAM policies that can be easily used.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| apigateway\_invoke | Boolean indicating whether to allow Invoke and Manage to APIGateway | `"false"` | no |
| apigateway\_invoke\_apis | A list of APIGateway APIs to allow Invoke and Manage | list | `<list>` | no |
| apigateway\_full\_access | Boolean indicating whether to create a policy to allow full access to APIGateway APIs | string | `"false"` | no |
| apigateway\_full\_access\_apis | A list of APIGateway APIs to allow full access to | list | `<list>` | no |
| apigateway\_post | Boolean indicating whether to create a policy to allow post access to APIGateway APIs | string | `"false"` | no |
| apigateway\_post\_apis | A list of APIGateway APIs to allow posting to | list | `<list>` | no |
| apigateway\_read | Boolean indicating whether to create a policy to allow read only access to APIGateway APIs | string | `"false"` | no |
| apigateway\_read\_apis | A list of APIGateway APIs to allow reading from | list | `<list>` | no |
| apigateway\_write | Boolean indicating whether to create a policy to allow write access to APIGateway APIs | string | `"false"` | no |
| apigateway\_write\_apis | A list of APIGateway APIs to allow writing to | list | `<list>` | no |
| cloudcraft\_access | Whether to add a statement with the permissions required for Cloudcraft to access the account | string | `"false"` | no |
| cloudwatch\_full\_access | Boolean indicating whether to give Full Access to CloudWatch. | string | `"false"` | no |
| cloudwatch\_full\_access\_resources | A list of CloudWatch resources to which the user has Full Access too. | list | `<list>` | no |
| cloudwatch\_read | Boolean indicating whether to give Read Only access to CloudWatch. | string | `"false"` | no |
| cloudwatch\_read\_only\_resources | A list of Cloudwatch resources to which the user has Read Only access too. | list | `<list>` | no |
| dynamodb\_full\_access | Boolean indicating whether to create a policy to allow full access to dynamodb tables | string | `"false"` | no |
| dynamodb\_full\_access\_tables | A list of dynamodb tables to allow full access to | list | `<list>` | no |
| dynamodb\_list | Boolean indicating whether to create a policy to allow listing dynamodb tables (this is automatically added if any other access to dynamodb is granted) | string | `"false"` | no |
| dynamodb\_read | Boolean indicating whether to create a policy to allow read only access to dynamodb tables | string | `"false"` | no |
| dynamodb\_read\_tables | A list of dynamodb tables to allow reading from | list | `<list>` | no |
| dynamodb\_write | Boolean indicating whether to create a policy to allow write access to dynamodb tables | string | `"false"` | no |
| dynamodb\_write\_tables | A list of dynamodb tables to allow writing to | list | `<list>` | no |
| ec2\_full\_access | Boolean indicating whether to give Full Access to EC2 instances. | string | `"false"` | no |
| ec2\_full\_access\_instances | A list of EC2 instances which the user has Full Access too. | list | `<list>` | no |
| ec2\_read | Boolean indicating whether to give Read Only access to EC2 instances. | string | `"false"` | no |
| ec2\_read\_instances | A list of EC2 instances which the user has Read Only access too. | list | `<list>` | no |
| iam\_change\_password | Boolean indicating whether to give the policy the IAM:ChangePassword permission | string | `"false"` | no |
| iam\_get\_account\_password\_policy | Boolean indicating whether to give the policy the IAM:GetAccountPasswordPolicy permission | string | `"false"` | no |
| iam\_manage\_access\_key | Boolean indicating whether to give the policy the IAM:*AccessKey* permission | string | `"false"` | no |
| lambda\_full\_access | Whether to grant full access to the Lambda. | string | `"false"` | no |
| lambda\_full\_access\_functions | List of functions to grant full access access to | list | `<list>` | no |
| lambda\_invoke | Whether to grant access to invoke Lambda functions | string | `"false"` | no |
| lambda\_invoke\_functions | List of functions to grant invoke access to | list | `<list>` | no |
| lambda\_list | Whether to create a policy to allowing listing of Lambda functions. | string | `"false"` | no |
| lambda\_read | Whether to create a policy to allow reading of specified Lambda functions. | string | `"false"` | no |
| lambda\_read\_functions | List of functions to grant read access to | list | `<list>` | no |
| lambda\_write | Whether to grant write access to specified Lambda functions. | string | `"false"` | no |
| lambda\_write\_functions | List of functions to grant write access to | list | `<list>` | no |
| managed\_policy\_arns | A list of existing policy document ARNs to merge into the created policies. You can specify policy versions by appending ':VersionId' e.g. ':v1' to the ARN. | list | `<list>` | no |
| policy\_type | The type of policy to generate. Valid types are: user, group, role. This is used to determine the maximum allowed length of the policy. | string | n/a | yes |
| policy\_type\_length\_limit | A map containing maximum length of the various types of IAM policy (user, group or role). | map | `<map>` | no |
| policy\_version | The IAM policy version to use when generating the condensed policies. | string | `"2012-10-17"` | no |
| redshift\_full\_access | Boolean indicating whether to give Full Access to the Redshift instances. | string | `"false"` | no |
| redshift\_full\_access\_instances | A list of Redshift instances which the user has Full Access too. | list | `<list>` | no |
| redshift\_read | Boolean indicating whether to give Read Only access to Redshift. | string | `"false"` | no |
| redshift\_read\_only\_instances | A list of Redshift instances which the user has Read Only access too. | list | `<list>` | no |
| s3\_full\_access | Boolean indicating whether to create a policy to allow full access to a bucket (including modifying and deleting the bucket) | string | `"false"` | no |
| s3\_full\_access\_buckets | A list of S3 buckets to create policies to allow full access to | list | `<list>` | no |
| s3\_list | Boolean indicating whether to create a policy to allow listing buckets (this is automatically added if any other access to buckets is granted) | string | `"false"` | no |
| s3\_read | Boolean indicating whether to create a policy to allow List/Get objects in a bucket | string | `"false"` | no |
| s3\_read\_buckets | A list of S3 buckets to create allow access to via the generated policies | list | `<list>` | no |
| s3\_write | Boolean indicating whether to create a policy to allow write access to a buckets objects and their ACLs. | string | `"false"` | no |
| s3\_write\_buckets | A list of S3 buckets to create policies to allow writing to | list | `<list>` | no |
| sns\_full\_access | Boolean indicating whether to give Full Access to the SNS Topics. | string | `"false"` | no |
| sns\_full\_access\_topics | A list of SNS Topics which the user has Full Access too. | list | `<list>` | no |
| sns\_list | Boolean indicating whether to create a policy to allow listing SNS topics (this is automatically added if any other access to buckets is granted) | string | `"false"` | no |
| sns\_read | Boolean indicating whether to give Read Only access to SNS Topics. | string | `"false"` | no |
| sns\_read\_topics | A list of SNS Topics which the user has Read Only access too. | list | `<list>` | no |
| sns\_write | Boolean indicating whether to create a policy to allow write access to a SNS topics. | string | `"false"` | no |
| sns\_write\_topics | A list of SNS topics to create policies to allow writing to. | list | `<list>` | no |
| sqs\_full\_access | Boolean indicating whether to create a policy to allow full access to a SQS queue (including modifying and deleting the queue) | string | `"false"` | no |
| sqs\_full\_access\_queues | A list of SQS queues to allow full access to | list | `<list>` | no |
| sqs\_list | Boolean indicating whether to create a policy to allow listing SQS queues (this is automatically added if any other access to SQS queues is granted) | string | `"false"` | no |
| sqs\_read | Boolean indicating whether to create a policy to allow list and read queue messages. | string | `"false"` | no |
| sqs\_read\_queues | A list of SQS queues to allow read access to via the generated policies | list | `<list>` | no |
| sqs\_write | Boolean indicating whether to create a policy to allow write access to a SQS queues and their messages. | string | `"false"` | no |
| sqs\_write\_queues | A list of SQS queues to allow writing to | list | `<list>` | no |
| ssm\_parameters\_full\_access | Whether to grant full access to the System Manager Parameter Store Parameters. | string | `"false"` | no |
| ssm\_parameters\_full\_access\_params | List of System Manager Parameter Store Parameters to grant full access access to | list | `<list>` | no |
| ssm\_parameters\_list | Whether to create a policy to allowing listing of Systems Manager Parameter Store Parameters. | string | `"false"` | no |
| ssm\_parameters\_read | Whether to create a policy to allow reading of specified Systems Manager Parameter Store Parameters. | string | `"false"` | no |
| ssm\_parameters\_read\_params | List of System Manager Parameter Store Parameters to grant read access to | list | `<list>` | no |
| ssm\_parameters\_write | Whether to grant write access to specified Systems Manager Parameter Store Parameters. | string | `"false"` | no |
| ssm\_parameters\_write\_params | List of System Manager Parameter Store Parameters to grant write access to | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| managed\_policies |  |
| policies | A list of 1 or more IAM Policy documents in JSON format. These should be used with the aws_iam_policy resource to create the policies for the user, group or role. |
| policy\_count | The number of policies being returned. This is to help avoid the dreaded Terraform 'value cannot be computed'. |
