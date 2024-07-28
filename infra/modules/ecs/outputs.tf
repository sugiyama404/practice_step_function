output "ecs_cluster_arn" {
  value = aws_ecs_cluster.MainCluster.arn
}

output "ecs_cloudwatch_logs_group_arn" {
  value = aws_cloudwatch_log_group.ECSlog.arn
}
