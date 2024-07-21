data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "./modules/lambda/src/in"
  output_path = "./modules/lambda/src/out/lambda_function_payload.zip"
}

resource "aws_lambda_function" "main" {
  filename         = "./modules/lambda/src/out/lambda_function_payload.zip"
  function_name    = var.lambda_function_name
  description      = "lambda_function"
  role             = var.lambda_iam_role
  architectures    = ["x86_64"]
  handler          = "index.lambda_handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  timeout          = 30
  runtime          = "python3.9"
  depends_on       = [aws_cloudwatch_log_group.lambda]

  environment {
    variables = {
      SNS_TOPIC_ARN = var.sns_topic_arn
    }
  }
  tags = {
    Name = "${var.app_name}-lamdba"
  }
}
