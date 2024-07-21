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
  source   = "./modules/iam"
  app_name = var.app_name
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
  ecs_iam_role                = module.iam.ecs_iam_role
  api_repository_url          = module.ecr.api_repository_url
  api_port                    = var.api_port
  webserver_log_group_name    = var.webserver_log_group_name
}

module "cloudwatch" {
  source                   = "./modules/cloudwatch"
  app_name                 = var.app_name
  lambda_function_arn      = module.lambda.lambda_function_arn
  webserver_log_group_name = var.webserver_log_group_name
}

module "lambda" {
  source                        = "./modules/lambda"
  app_name                      = var.app_name
  lambda_iam_role               = module.iam.lambda_iam_role
  lambda_function_name          = var.lambda_function_name
  sns_topic_arn                 = module.sns.sns_topic_arn
  cloudwatch_lambda_trigger_arn = module.cloudwatch.cloudwatch_lambda_trigger_arn
  region                        = var.region
  webserver_log_group_name      = var.webserver_log_group_name
}

module "sns" {
  source   = "./modules/sns"
  app_name = var.app_name
}


