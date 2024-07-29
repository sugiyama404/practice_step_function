variable "app_name" {}
variable "webserver_log_group_name" {}
variable "sfn_ecs_stop_state_machine_arn" {}
data "aws_caller_identity" "self" {}
locals {
  account_id = data.aws_caller_identity.self.account_id
}
variable "region" {}
