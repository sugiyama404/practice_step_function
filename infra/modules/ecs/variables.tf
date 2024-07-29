variable "sg_ecs_id" {}
variable "subnet_private_subnet_1a_id" {}
variable "subnet_public_subnet_1a_id" {}
variable "iam_role_arn_for_ecs" {}
variable "app_name" {}
variable "api_repository_url" {}
variable "api_port" {}
variable "webserver_log_group_name" {}
variable "region" {}
data "aws_caller_identity" "self" {}
locals {
  account_id = data.aws_caller_identity.self.account_id
}
