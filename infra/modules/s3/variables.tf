variable "app_name" {}
variable "region" {}
data "aws_caller_identity" "self" {}
data "aws_partition" "current" {}
locals {
  account_id = data.aws_caller_identity.self.account_id
  partition  = data.aws_partition.current.partition
}
