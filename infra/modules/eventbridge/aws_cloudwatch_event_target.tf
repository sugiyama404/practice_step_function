# EventBridge Target
resource "aws_cloudwatch_event_target" "ecs_task_start_target" {
  rule      = aws_cloudwatch_event_rule.ecs_task_start_rule.name
  target_id = "ecsTaskStartTarget"
  arn       = var.sfn_ecs_stop_state_machine_arn
}
