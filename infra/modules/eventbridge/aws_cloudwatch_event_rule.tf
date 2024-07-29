resource "aws_cloudwatch_event_rule" "ecs_task_start_rule" {
  name        = "ecsTaskStartRule"
  description = "Rule to trigger Step Functions on ECS task start"
  event_pattern = jsonencode({
    source      = ["aws.ecs"]
    detail-type = ["ECS Task State Change"]
    detail = {
      lastStatus = ["RUNNING"]
    }
  })
}
