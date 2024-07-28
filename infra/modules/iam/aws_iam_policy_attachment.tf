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

resource "aws_iam_policy_attachment" "cloudtrail_role_attachment" {
  name       = "${var.app_name}-cloudtrail-attach"
  roles      = ["${aws_iam_role.cloudtrail_role.name}"]
  policy_arn = aws_iam_policy.cloudtrail_policy.arn
}

resource "aws_iam_role_policy_attachment" "step_functions_policy_attachment" {
  role       = aws_iam_role.step_functions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSStepFunctionsFullAccess"
}
