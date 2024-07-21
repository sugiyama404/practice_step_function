resource "aws_iam_policy_attachment" "ecr_attach" {
  name       = "${var.app_name}-ecr-attach"
  roles      = ["${aws_iam_role.ecs_role.name}"]
  policy_arn = aws_iam_policy.ecr_policy.arn
}

resource "aws_iam_policy_attachment" "cloudwatch_attach" {
  name       = "${var.app_name}-cloudwatch-attach"
  roles      = ["${aws_iam_role.ecs_role.name}"]
  policy_arn = aws_iam_policy.cloudwatch_policy.arn
}

resource "aws_iam_policy_attachment" "lambda_role_attachment" {
  name       = "${var.app_name}-lambda-attach"
  roles      = ["${aws_iam_role.lambda_role.name}"]
  policy_arn = aws_iam_policy.lambda_policy.arn
}
