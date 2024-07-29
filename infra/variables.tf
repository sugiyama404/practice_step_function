variable "app_name" {
  description = "application name"
  type        = string
  default     = "chatbot"
}

variable "region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "ap-northeast-1"
}

variable "image_name" {
  description = "application name"
  type        = string
  default     = "transformer"
}

variable "api_port" {
  description = "api port"
  type        = number
  default     = 3000
}

variable "webserver_log_group_name" {
  description = "webserver log group name"
  type        = string
  default     = "/fargate/container/dev"
}

variable "lambda_function_name" {
  description = "Lambda function name"
  type        = string
  default     = "lambda_function"
}
