resource "aws_cloudtrail" "main" {
  name                          = "my-cloudtrail"
  s3_bucket_name                = var.s3_bucket_id
  include_global_service_events = true
  s3_key_prefix                 = "prefix"
  enable_logging                = true

  cloud_watch_logs_group_arn = "${var.ecs_cloudwatch_logs_group_arn}:*"
  cloud_watch_logs_role_arn  = var.iam_role_arn_for_cloudtrail

  # insight_selector {
  #   insight_type = "ApiCallRateInsight"
  # }
}
