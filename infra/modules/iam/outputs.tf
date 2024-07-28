output "iam_role_arn_for_ecs" {
  value = aws_iam_role.ecs_role.arn
}

output "iam_role_arn_for_lambda" {
  value = aws_iam_role.lambda_role.arn
}

output "iam_role_arn_for_stepfunction" {
  value = aws_iam_role.step_functions_role.arn
}

output "iam_role_arn_for_cloudtrail" {
  value = aws_iam_role.cloudtrail_role.arn
}


