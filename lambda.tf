resource "aws_lambda_function" "api" {
  filename      = "src/main.zip"
  function_name = "${var.function_name}"
  role          = "${aws_iam_role.iam_for_lambda.arn}"
  handler       = "main"

  source_code_hash = "${base64sha256(file("src/main.zip"))}"
  runtime          = "go1.x"

  environment {
    variables = "${var.environment_variables}"
  }
}

resource "aws_lambda_function" "api-2" {
  filename      = "src/main.zip"
  function_name = "${var.function_name}-2"
  role          = "${aws_iam_role.iam_for_lambda.arn}"
  handler       = "main"

  source_code_hash = "${base64sha256(file("src/main.zip"))}"
  runtime          = "go1.x"

  environment {
    variables = "${var.environment_variables}"
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "${var.function_name}-lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "policy_for_lambda" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["${aws_cloudwatch_log_group.lambda-api.arn}"]
  }
}

resource "aws_iam_role_policy" "policy_for_lambda" {
  name   = "${var.function_name}-lambda"
  role   = "${aws_iam_role.iam_for_lambda.id}"
  policy = "${data.aws_iam_policy_document.policy_for_lambda.json}"
}

resource "aws_cloudwatch_log_group" "lambda-api" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = "${var.log_retention_in_days}"
}
