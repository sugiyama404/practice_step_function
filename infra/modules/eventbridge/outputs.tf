output "cloudwatch_ecs_task_start_rule_arn" {
  value = aws_cloudwatch_event_rule.ecs_task_start_rule.arn
}

