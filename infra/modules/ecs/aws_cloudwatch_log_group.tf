resource "aws_cloudwatch_log_group" "ECSlog" {
  name              = var.webserver_log_group_name
  retention_in_days = 1

  tags = {
    Name = "ecs-log"
  }
}
