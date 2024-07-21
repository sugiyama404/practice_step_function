resource "aws_cloudtrail" "main" {
  name                          = "my-cloudtrail"
  s3_bucket_name                = var.s3_bucket_id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_logging                = true

  event_selector {
    read_write_type           = "WriteOnly"
    include_management_events = true
    data_resource {
      type   = "AWS::ECS::Task"
      values = ["arn:aws:ecs:${var.region}:${local.account_id}:task/*"]
    }
  }

  depends_on = [aws_iam_role_policy_attachment.cloudtrail_attachment]
}
