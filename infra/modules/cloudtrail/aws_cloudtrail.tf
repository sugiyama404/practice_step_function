resource "aws_cloudtrail" "main" {
  name                          = "my-cloudtrail"
  s3_bucket_name                = var.s3_bucket_id
  include_global_service_events = true
  s3_key_prefix                 = "prefix"
  enable_logging                = true

  event_selector {
    read_write_type           = "WriteOnly"
    include_management_events = true
    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::${var.s3_bucket_id}/"]
    }
  }

}
