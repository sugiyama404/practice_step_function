variable "app_name" {}
variable "lambda_iam_role" {}
variable "lambda_function_name" {}
variable "sns_topic_arn" {}
variable "cloudwatch_lambda_trigger_arn" {}
variable "region" {}
variable "webserver_log_group_name" {}
data "aws_caller_identity" "self" {}
locals {
  account_id = data.aws_caller_identity.self.account_id
}
