variable "app_name" {}
variable "iam_role_arn_for_lambda" {}
variable "lambda_function_name" {}
variable "region" {}
data "aws_caller_identity" "self" {}
locals {
  account_id = data.aws_caller_identity.self.account_id
}
variable "cloudwatch_ecs_task_start_rule_arn" {}
variable "ecs_cluster_arn" {}
variable "ecs_cluster_name" {}
variable "ecs_task_arn" {}
