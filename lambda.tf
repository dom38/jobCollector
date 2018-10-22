resource "aws_lambda_function" "getActiveJobs" {

  function_name = "getActiveJobs"
  filename      = "lambda_function_payload.zip"
  handler = "getActiveJobs.handler"
  runtime = "java8"
  source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  role = "${aws_iam_role.lambda_exec.arn}"

}

resource "aws_lambda_function" "getAllJobs" {

  function_name = "getAllJobs"
  filename      = "lambda_function_payload.zip"
  handler = "getAllJobs.handler"
  runtime = "java8"
  source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  role = "${aws_iam_role.lambda_exec.arn}"

}

resource "aws_lambda_function" "updateExistingJobs" {

  function_name = "updateExistingJobs"
  filename      = "lambda_function_payload.zip"
  handler = "updateExistingJobs.handler"
  runtime = "java8"
  source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  role = "${aws_iam_role.lambda_exec.arn}"

}

resource "aws_lambda_function" "postNewJob" {

  function_name = "postNewJob"
  filename      = "lambda_function_payload.zip"
  handler = "postNewJob.handler"
  runtime = "java8"
  source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  role = "${aws_iam_role.lambda_exec.arn}"

}

resource "aws_iam_role" "lambda_exec" {
  name = "serverless_example_lambda"

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