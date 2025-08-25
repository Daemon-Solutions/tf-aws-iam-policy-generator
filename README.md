# tf-aws-iam-policy-generator

A module similar to tf-aws-iam-instance-profile for generating IAM policies for various different uses. e.g. policies for attaching to user, groups or roles. The purpose of this is to allow us to have well tested IAM policies that can be easily used.

## Terraform version compatibility

| Module version | Terraform version |
|----------------|-------------------|
| 2.x.x          | 0.12.x            |
| 1.x.x          | 0.11.x            |

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
| cloudwatch\_full\_access\_dashboard | Boolean indicating whether to give Read Only access to CloudWatch. | string | `"false"` | no |
| cloudwatch\_full\_access\_dashboard\_resources | A list of Cloudwatch resources to which the user has Full Dashboard access. | list | `<list>` | no |
| cloudwatch\_full\_alarm\_access | Boolean indicating whether to give Full Access to CloudWatch Alarms. | string | `"false"` | no |
| cloudwatch\_full\_alarm\_access\_resources | A list of CloudWatch Alarm resources to which the user has Full Access too. | list | `<list>` | no |
| cloudwatch\_read | Boolean indicating whether to give Read Only access to CloudWatch. | string | `"false"` | no |
| cloudwatch\_read\_only\_resources | A list of Cloudwatch resources to which the user has Read Only access too. | list | `<list>` | no |
| cloudwatch\_event\_full\_access| Boolean indicating whether to give Full Access to CloudWatch Events. | list | `<list>` | no |
| cloudwatch\_event\_full\_access\_resources | A list of Cloudwatch Event resources to which the user has Full  access too. | list | `<list>` | no |
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
| ecs\_list | Whether to create a policy to allowing listing of ECS Clusters. | string | `"false"` | no |
| ecs\_read | Whether to create a policy to allow reading of specified ECS Cluster.. | string | `"false"` | no |
| ecs\_read\_cluster | List of ECS to grant read access to | list | `<list>` | no |
| ecs\_write | Whether to grant write access to specified ECS Cluster. | string | `"false"` | no |
| ecs\_write\_cluster | List of ECS to grant write access to | list | `<list>` | no |
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
| pi\_full\_access | Boolean indicating whether to Provide Full PI RDS access | string | `"false"` | no |
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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_external"></a> [external](#provider\_external) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_policy_condenser"></a> [policy\_condenser](#module\_policy\_condenser) | git@github.com:Daemon-Solutions/tf-aws-iam-policy-condenser.git | v2.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.apigateway_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.apigateway_invoke](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.apigateway_post](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.apigateway_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.apigateway_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudcraft_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch_event_full_access_resources](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch_full_access_dashboard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch_full_alarm_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch_read_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.dynamodb_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.dynamodb_list](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.dynamodb_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.dynamodb_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ec2_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ec2_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_list](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.iam_change_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.iam_get_account_password_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.iam_manage_access_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_invoke](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_list](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.pi_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.redshift_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.redshift_read_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_list](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns_list](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sqs_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sqs_list_queues](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sqs_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sqs_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ssm_parameters_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ssm_parameters_list](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ssm_parameters_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ssm_parameters_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [external_external.policy_fetcher](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [template_file.managed_policies](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apigateway_full_access"></a> [apigateway\_full\_access](#input\_apigateway\_full\_access) | Boolean indicating whether to create a policy to allow full access to APIGateway APIs | `string` | `false` | no |
| <a name="input_apigateway_full_access_apis"></a> [apigateway\_full\_access\_apis](#input\_apigateway\_full\_access\_apis) | A list of APIGateway APIs to allow full access to | `list(string)` | `[]` | no |
| <a name="input_apigateway_invoke"></a> [apigateway\_invoke](#input\_apigateway\_invoke) | Boolean indicating whether to allow Invoke and Manage to APIGateway | `string` | `false` | no |
| <a name="input_apigateway_invoke_apis"></a> [apigateway\_invoke\_apis](#input\_apigateway\_invoke\_apis) | A list of APIGateway APIs to allow Invoke and Manage | `list(string)` | `[]` | no |
| <a name="input_apigateway_post"></a> [apigateway\_post](#input\_apigateway\_post) | Boolean indicating whether to create a policy to allow post access to APIGateway APIs | `bool` | `false` | no |
| <a name="input_apigateway_post_apis"></a> [apigateway\_post\_apis](#input\_apigateway\_post\_apis) | A list of APIGateway APIs to allow posting to | `list(string)` | `[]` | no |
| <a name="input_apigateway_read"></a> [apigateway\_read](#input\_apigateway\_read) | Boolean indicating whether to create a policy to allow read only access to APIGateway APIs | `bool` | `false` | no |
| <a name="input_apigateway_read_apis"></a> [apigateway\_read\_apis](#input\_apigateway\_read\_apis) | A list of APIGateway APIs to allow reading from | `list(string)` | `[]` | no |
| <a name="input_apigateway_write"></a> [apigateway\_write](#input\_apigateway\_write) | Boolean indicating whether to create a policy to allow write access to APIGateway APIs | `string` | `false` | no |
| <a name="input_apigateway_write_apis"></a> [apigateway\_write\_apis](#input\_apigateway\_write\_apis) | A list of APIGateway APIs to allow writing to | `list(string)` | `[]` | no |
| <a name="input_cloudcraft_access"></a> [cloudcraft\_access](#input\_cloudcraft\_access) | Whether to add a statement with the permissions required for Cloudcraft to access the account | `bool` | `false` | no |
| <a name="input_cloudwatch_event_full_access"></a> [cloudwatch\_event\_full\_access](#input\_cloudwatch\_event\_full\_access) | Boolean indicating whether to give Full Access to CloudWatch Events. | `bool` | `false` | no |
| <a name="input_cloudwatch_event_full_access_resources"></a> [cloudwatch\_event\_full\_access\_resources](#input\_cloudwatch\_event\_full\_access\_resources) | A list of CloudWatch Event resources to which the user has Full Access too. | `list(string)` | `[]` | no |
| <a name="input_cloudwatch_full_access"></a> [cloudwatch\_full\_access](#input\_cloudwatch\_full\_access) | Boolean indicating whether to give Full Access to CloudWatch. | `bool` | `false` | no |
| <a name="input_cloudwatch_full_access_dashboard"></a> [cloudwatch\_full\_access\_dashboard](#input\_cloudwatch\_full\_access\_dashboard) | Boolean indicating whether to give Full Dashboard access to CloudWatch. | `string` | `false` | no |
| <a name="input_cloudwatch_full_access_dashboard_resources"></a> [cloudwatch\_full\_access\_dashboard\_resources](#input\_cloudwatch\_full\_access\_dashboard\_resources) | A list of Cloudwatch resources to which the user has Full Dashboard access. | `list(string)` | `[]` | no |
| <a name="input_cloudwatch_full_access_resources"></a> [cloudwatch\_full\_access\_resources](#input\_cloudwatch\_full\_access\_resources) | A list of CloudWatch resources to which the user has Full Access too. | `list(string)` | `[]` | no |
| <a name="input_cloudwatch_full_alarm_access"></a> [cloudwatch\_full\_alarm\_access](#input\_cloudwatch\_full\_alarm\_access) | Boolean indicating whether to give Full access to CloudWatch Alarms. | `string` | `false` | no |
| <a name="input_cloudwatch_full_alarm_access_resources"></a> [cloudwatch\_full\_alarm\_access\_resources](#input\_cloudwatch\_full\_alarm\_access\_resources) | A list of Cloudwatch Alarms resources to which the user has Full access. | `list(string)` | `[]` | no |
| <a name="input_cloudwatch_read"></a> [cloudwatch\_read](#input\_cloudwatch\_read) | Boolean indicating whether to give Read Only access to CloudWatch. | `bool` | `false` | no |
| <a name="input_cloudwatch_read_only_resources"></a> [cloudwatch\_read\_only\_resources](#input\_cloudwatch\_read\_only\_resources) | A list of Cloudwatch resources to which the user has Read Only access too. | `list(string)` | `[]` | no |
| <a name="input_dynamodb_full_access"></a> [dynamodb\_full\_access](#input\_dynamodb\_full\_access) | Boolean indicating whether to create a policy to allow full access to dynamodb tables | `bool` | `false` | no |
| <a name="input_dynamodb_full_access_tables"></a> [dynamodb\_full\_access\_tables](#input\_dynamodb\_full\_access\_tables) | A list of dynamodb tables to allow full access to | `list(string)` | `[]` | no |
| <a name="input_dynamodb_list"></a> [dynamodb\_list](#input\_dynamodb\_list) | Boolean indicating whether to create a policy to allow listing dynamodb tables (this is automatically added if any other access to dynamodb is granted) | `bool` | `false` | no |
| <a name="input_dynamodb_read"></a> [dynamodb\_read](#input\_dynamodb\_read) | Boolean indicating whether to create a policy to allow read only access to dynamodb tables | `bool` | `false` | no |
| <a name="input_dynamodb_read_tables"></a> [dynamodb\_read\_tables](#input\_dynamodb\_read\_tables) | A list of dynamodb tables to allow reading from | `list(string)` | `[]` | no |
| <a name="input_dynamodb_write"></a> [dynamodb\_write](#input\_dynamodb\_write) | Boolean indicating whether to create a policy to allow write access to dynamodb tables | `bool` | `false` | no |
| <a name="input_dynamodb_write_tables"></a> [dynamodb\_write\_tables](#input\_dynamodb\_write\_tables) | A list of dynamodb tables to allow writing to | `list(string)` | `[]` | no |
| <a name="input_ec2_full_access"></a> [ec2\_full\_access](#input\_ec2\_full\_access) | Boolean indicating whether to give Full Access to EC2 instances. | `bool` | `false` | no |
| <a name="input_ec2_full_access_instances"></a> [ec2\_full\_access\_instances](#input\_ec2\_full\_access\_instances) | A list of EC2 instances which the user has Full Access too. | `list(string)` | `[]` | no |
| <a name="input_ec2_read"></a> [ec2\_read](#input\_ec2\_read) | Boolean indicating whether to give Read Only access to EC2 instances. | `bool` | `false` | no |
| <a name="input_ec2_read_instances"></a> [ec2\_read\_instances](#input\_ec2\_read\_instances) | A list of EC2 instances which the user has Read Only access too. | `list(string)` | `[]` | no |
| <a name="input_ecs_list"></a> [ecs\_list](#input\_ecs\_list) | Whether to create a policy to allowing listing of ECS Clusters. | `bool` | `false` | no |
| <a name="input_ecs_read"></a> [ecs\_read](#input\_ecs\_read) | Whether to create a policy to allow reading of specified ECS Cluster. | `bool` | `false` | no |
| <a name="input_ecs_read_cluster"></a> [ecs\_read\_cluster](#input\_ecs\_read\_cluster) | List of ECS to grant read access to | `list(string)` | `[]` | no |
| <a name="input_ecs_write"></a> [ecs\_write](#input\_ecs\_write) | Whether to grant write access to specified ECS Cluster. | `bool` | `false` | no |
| <a name="input_ecs_write_cluster"></a> [ecs\_write\_cluster](#input\_ecs\_write\_cluster) | List of ECS to grant write access to | `list(string)` | `[]` | no |
| <a name="input_iam_change_password"></a> [iam\_change\_password](#input\_iam\_change\_password) | Boolean indicating whether to give the policy the IAM:ChangePassword permission | `bool` | `false` | no |
| <a name="input_iam_get_account_password_policy"></a> [iam\_get\_account\_password\_policy](#input\_iam\_get\_account\_password\_policy) | Boolean indicating whether to give the policy the IAM:GetAccountPasswordPolicy permission | `bool` | `false` | no |
| <a name="input_iam_manage_access_key"></a> [iam\_manage\_access\_key](#input\_iam\_manage\_access\_key) | Boolean indicating whether to give the policy the IAM:*AccessKey* permission | `bool` | `false` | no |
| <a name="input_lambda_full_access"></a> [lambda\_full\_access](#input\_lambda\_full\_access) | Whether to grant full access to the Lambda. | `bool` | `false` | no |
| <a name="input_lambda_full_access_functions"></a> [lambda\_full\_access\_functions](#input\_lambda\_full\_access\_functions) | List of functions to grant full access access to | `list(string)` | `[]` | no |
| <a name="input_lambda_invoke"></a> [lambda\_invoke](#input\_lambda\_invoke) | Whether to grant access to invoke Lambda functions | `bool` | `false` | no |
| <a name="input_lambda_invoke_functions"></a> [lambda\_invoke\_functions](#input\_lambda\_invoke\_functions) | List of functions to grant invoke access to | `list(string)` | `[]` | no |
| <a name="input_lambda_list"></a> [lambda\_list](#input\_lambda\_list) | Whether to create a policy to allowing listing of Lambda functions. | `bool` | `false` | no |
| <a name="input_lambda_read"></a> [lambda\_read](#input\_lambda\_read) | Whether to create a policy to allow reading of specified Lambda functions. | `bool` | `false` | no |
| <a name="input_lambda_read_functions"></a> [lambda\_read\_functions](#input\_lambda\_read\_functions) | List of functions to grant read access to | `list(string)` | `[]` | no |
| <a name="input_lambda_write"></a> [lambda\_write](#input\_lambda\_write) | Whether to grant write access to specified Lambda functions. | `bool` | `false` | no |
| <a name="input_lambda_write_functions"></a> [lambda\_write\_functions](#input\_lambda\_write\_functions) | List of functions to grant write access to | `list(string)` | `[]` | no |
| <a name="input_managed_policies"></a> [managed\_policies](#input\_managed\_policies) | Boolean indicating whether to allow Invoke and Manage to APIGateway. | `bool` | `true` | no |
| <a name="input_managed_policy_arns"></a> [managed\_policy\_arns](#input\_managed\_policy\_arns) | A list of existing policy document ARNs to merge into the created policies. You can specify policy versions by appending ':VersionId' e.g. ':v1' to the ARN. | `list` | `[]` | no |
| <a name="input_pi_full_access"></a> [pi\_full\_access](#input\_pi\_full\_access) | Boolean indicating whether to Provide Full PI RDS access | `bool` | `false` | no |
| <a name="input_policy_type"></a> [policy\_type](#input\_policy\_type) | The type of policy to generate. Valid types are: user, group, role. This is used to determine the maximum allowed length of the policy. | `string` | n/a | yes |
| <a name="input_policy_type_length_limit"></a> [policy\_type\_length\_limit](#input\_policy\_type\_length\_limit) | A map containing maximum length of the various types of IAM policy (user, group or role). | `map(string)` | <pre>{<br>  "group": 10240,<br>  "role": 5120,<br>  "user": 2048<br>}</pre> | no |
| <a name="input_policy_version"></a> [policy\_version](#input\_policy\_version) | The IAM policy version to use when generating the condensed policies. | `string` | `"2012-10-17"` | no |
| <a name="input_redshift_full_access"></a> [redshift\_full\_access](#input\_redshift\_full\_access) | Boolean indicating whether to give Full Access to the Redshift instances. | `bool` | `false` | no |
| <a name="input_redshift_full_access_instances"></a> [redshift\_full\_access\_instances](#input\_redshift\_full\_access\_instances) | A list of Redshift instances which the user has Full Access too. | `list(string)` | `[]` | no |
| <a name="input_redshift_read"></a> [redshift\_read](#input\_redshift\_read) | Boolean indicating whether to give Read Only access to Redshift. | `bool` | `false` | no |
| <a name="input_redshift_read_only_instances"></a> [redshift\_read\_only\_instances](#input\_redshift\_read\_only\_instances) | A list of Redshift instances which the user has Read Only access too. | `list(string)` | `[]` | no |
| <a name="input_s3_full_access"></a> [s3\_full\_access](#input\_s3\_full\_access) | Boolean indicating whether to create a policy to allow full access to a bucket (including modifying and deleting the bucket) | `bool` | `false` | no |
| <a name="input_s3_full_access_buckets"></a> [s3\_full\_access\_buckets](#input\_s3\_full\_access\_buckets) | A list of S3 buckets to create policies to allow full access to | `list(string)` | `[]` | no |
| <a name="input_s3_list"></a> [s3\_list](#input\_s3\_list) | Boolean indicating whether to create a policy to allow listing buckets (this is automatically added if any other access to buckets is granted) | `bool` | `false` | no |
| <a name="input_s3_read"></a> [s3\_read](#input\_s3\_read) | Boolean indicating whether to create a policy to allow List/Get objects in a bucket | `bool` | `false` | no |
| <a name="input_s3_read_buckets"></a> [s3\_read\_buckets](#input\_s3\_read\_buckets) | A list of S3 buckets to create allow access to via the generated policies | `list(string)` | `[]` | no |
| <a name="input_s3_write"></a> [s3\_write](#input\_s3\_write) | Boolean indicating whether to create a policy to allow write access to a buckets objects and their ACLs. | `bool` | `false` | no |
| <a name="input_s3_write_buckets"></a> [s3\_write\_buckets](#input\_s3\_write\_buckets) | A list of S3 buckets to create policies to allow writing to | `list(string)` | `[]` | no |
| <a name="input_sns_full_access"></a> [sns\_full\_access](#input\_sns\_full\_access) | Boolean indicating whether to give Full Access to the SNS Topics. | `bool` | `false` | no |
| <a name="input_sns_full_access_topics"></a> [sns\_full\_access\_topics](#input\_sns\_full\_access\_topics) | A list of SNS Topics which the user has Full Access too. | `list(string)` | `[]` | no |
| <a name="input_sns_list"></a> [sns\_list](#input\_sns\_list) | Boolean indicating whether to create a policy to allow listing SNS topics (this is automatically added if any other access to buckets is granted) | `bool` | `false` | no |
| <a name="input_sns_read"></a> [sns\_read](#input\_sns\_read) | Boolean indicating whether to give Read Only access to SNS Topics. | `bool` | `false` | no |
| <a name="input_sns_read_topics"></a> [sns\_read\_topics](#input\_sns\_read\_topics) | A list of SNS Topics which the user has Read Only access too. | `list(string)` | `[]` | no |
| <a name="input_sns_write"></a> [sns\_write](#input\_sns\_write) | Boolean indicating whether to create a policy to allow write access to a SNS topics. | `bool` | `false` | no |
| <a name="input_sns_write_topics"></a> [sns\_write\_topics](#input\_sns\_write\_topics) | A list of SNS topics to create policies to allow writing to. | `any` | `[]` | no |
| <a name="input_sqs_full_access"></a> [sqs\_full\_access](#input\_sqs\_full\_access) | Boolean indicating whether to create a policy to allow full access to a SQS queue (including modifying and deleting the queue) | `bool` | `false` | no |
| <a name="input_sqs_full_access_queues"></a> [sqs\_full\_access\_queues](#input\_sqs\_full\_access\_queues) | A list of SQS queues to allow full access to | `list(string)` | `[]` | no |
| <a name="input_sqs_list"></a> [sqs\_list](#input\_sqs\_list) | Boolean indicating whether to create a policy to allow listing SQS queues (this is automatically added if any other access to SQS queues is granted) | `bool` | `false` | no |
| <a name="input_sqs_read"></a> [sqs\_read](#input\_sqs\_read) | Boolean indicating whether to create a policy to allow list and read queue messages. | `bool` | `false` | no |
| <a name="input_sqs_read_queues"></a> [sqs\_read\_queues](#input\_sqs\_read\_queues) | A list of SQS queues to allow read access to via the generated policies | `any` | `[]` | no |
| <a name="input_sqs_write"></a> [sqs\_write](#input\_sqs\_write) | Boolean indicating whether to create a policy to allow write access to a SQS queues and their messages. | `bool` | `false` | no |
| <a name="input_sqs_write_queues"></a> [sqs\_write\_queues](#input\_sqs\_write\_queues) | A list of SQS queues to allow writing to | `any` | `[]` | no |
| <a name="input_ssm_parameters_full_access"></a> [ssm\_parameters\_full\_access](#input\_ssm\_parameters\_full\_access) | Whether to grant full access to the System Manager Parameter Store Parameters. | `bool` | `false` | no |
| <a name="input_ssm_parameters_full_access_params"></a> [ssm\_parameters\_full\_access\_params](#input\_ssm\_parameters\_full\_access\_params) | List of System Manager Parameter Store Parameters to grant full access access to | `list(string)` | `[]` | no |
| <a name="input_ssm_parameters_list"></a> [ssm\_parameters\_list](#input\_ssm\_parameters\_list) | Whether to create a policy to allowing listing of Systems Manager Parameter Store Parameters. | `bool` | `false` | no |
| <a name="input_ssm_parameters_read"></a> [ssm\_parameters\_read](#input\_ssm\_parameters\_read) | Whether to create a policy to allow reading of specified Systems Manager Parameter Store Parameters. | `bool` | `false` | no |
| <a name="input_ssm_parameters_read_params"></a> [ssm\_parameters\_read\_params](#input\_ssm\_parameters\_read\_params) | List of System Manager Parameter Store Parameters to grant read access to | `any` | `[]` | no |
| <a name="input_ssm_parameters_write"></a> [ssm\_parameters\_write](#input\_ssm\_parameters\_write) | Whether to grant write access to specified Systems Manager Parameter Store Parameters. | `bool` | `false` | no |
| <a name="input_ssm_parameters_write_params"></a> [ssm\_parameters\_write\_params](#input\_ssm\_parameters\_write\_params) | List of System Manager Parameter Store Parameters to grant write access to | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_managed_policies"></a> [managed\_policies](#output\_managed\_policies) | n/a |
| <a name="output_policies"></a> [policies](#output\_policies) | A list of 1 or more IAM Policy documents in JSON format. These should be used with the aws\_iam\_policy resource to create the policies for the user, group or role. |
| <a name="output_policy_count"></a> [policy\_count](#output\_policy\_count) | The number of policies being returned. This is to help avoid the dreaded Terraform 'value cannot be computed'. |
<!-- END_TF_DOCS -->