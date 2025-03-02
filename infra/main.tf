terraform {
  required_version = "=1.8.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "iam" {
  source                         = "./modules/iam"
  app_name                       = var.app_name
  webserver_log_group_name       = var.webserver_log_group_name
  region                         = var.region
  sfn_ecs_stop_state_machine_arn = module.stepfunction.sfn_ecs_stop_state_machine_arn
}

# ECR
module "ecr" {
  source     = "./modules/ecr"
  image_name = var.image_name
  app_name   = var.app_name
}

# BASH
module "bash" {
  source     = "./modules/bash"
  region     = var.region
  image_name = var.image_name
}

module "s3" {
  source   = "./modules/s3"
  app_name = var.app_name
  region   = var.region
}

# network
module "network" {
  source   = "./modules/network"
  app_name = var.app_name
  api_port = var.api_port
}

# ECS
module "ecs" {
  source                      = "./modules/ecs"
  app_name                    = var.app_name
  sg_ecs_id                   = module.network.sg_ecs_id
  subnet_private_subnet_1a_id = module.network.subnet_private_subnet_1a_id
  subnet_public_subnet_1a_id  = module.network.subnet_public_subnet_1a_id
  iam_role_arn_for_ecs        = module.iam.iam_role_arn_for_ecs
  api_repository_url          = module.ecr.api_repository_url
  api_port                    = var.api_port
  webserver_log_group_name    = var.webserver_log_group_name
  region                      = var.region
}

module "cloudtrail" {
  source                        = "./modules/cloudtrail"
  app_name                      = var.app_name
  region                        = var.region
  s3_bucket_id                  = module.s3.s3_bucket_id
  ecs_cloudwatch_logs_group_arn = module.ecs.ecs_cloudwatch_logs_group_arn
  iam_role_arn_for_cloudtrail   = module.iam.iam_role_arn_for_cloudtrail
}

module "eventbridge" {
  source                         = "./modules/eventbridge"
  sfn_ecs_stop_state_machine_arn = module.stepfunction.sfn_ecs_stop_state_machine_arn
  iam_role_arn_for_eventbrifge   = module.iam.iam_role_arn_for_eventbrifge
}

module "stepfunction" {
  source                        = "./modules/stepfunction"
  iam_role_arn_for_stepfunction = module.iam.iam_role_arn_for_stepfunction
  ecs_cluster_arn               = module.ecs.ecs_cluster_arn
  lambda_function_arn           = module.lambda.lambda_function_arn
}

module "lambda" {
  source                             = "./modules/lambda"
  app_name                           = var.app_name
  lambda_function_name               = var.lambda_function_name
  region                             = var.region
  iam_role_arn_for_lambda            = module.iam.iam_role_arn_for_lambda
  cloudwatch_ecs_task_start_rule_arn = module.eventbridge.cloudwatch_ecs_task_start_rule_arn
  ecs_cluster_arn                    = module.ecs.ecs_cluster_arn
  ecs_cluster_name                   = module.ecs.ecs_cluster_name
  ecs_task_arn                       = module.ecs.ecs_task_arn
}



