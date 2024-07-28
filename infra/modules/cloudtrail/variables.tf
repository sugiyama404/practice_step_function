variable "app_name" {}
variable "region" {}
data "aws_caller_identity" "self" {}
locals {
  account_id = data.aws_caller_identity.self.account_id
}
variable "s3_bucket_id" {}
variable "ecs_cloudwatch_logs_group_arn" {}
variable "iam_role_arn_for_cloudtrail" {}
