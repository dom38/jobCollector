resource "aws_lambda_function" "getActiveJobs" {

  function_name = "getActiveJobs"
  filename      = "lambda_function_payload.zip"
  handler = "GetActiveJobs.handler"
  runtime = "python3.6"
  source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  role = "${aws_iam_role.lambda_exec.arn}"

}

resource "aws_lambda_function" "getAllJobs" {

  function_name = "getAllJobs"
  filename      = "lambda_function_payload.zip"
  handler = "GetAllJobs.handler"
  runtime = "python3.6"
  source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  role = "${aws_iam_role.lambda_exec.arn}"

}

resource "aws_lambda_function" "updateExistingJobs" {

  function_name = "updateExistingJobs"
  filename      = "lambda_function_payload.zip"
  handler = "UpdateExistingJobs.handler"
  runtime = "python3.6"
  source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  role = "${aws_iam_role.lambda_exec.arn}"

}

resource "aws_lambda_function" "postNewJob" {

  function_name = "postNewJob"
  filename      = "lambda_function_payload.zip"
  handler = "PostNewJob.handler"
  runtime = "python3.6"
  source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  role = "${aws_iam_role.lambda_exec.arn}"

}

resource "aws_iam_role" "lambda_exec" {

  name = "Job-Bot-Lambda-Role"
  assume_role_policy = "${file("lambda-role.json")}"

}
