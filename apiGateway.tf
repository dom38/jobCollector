resource "aws_api_gateway_rest_api" "jobAPI" {

  name        = "JobBot API Gateway"
  description = "Gateway for serverless actions"
  
}

resource "aws_api_gateway_resource" "proxy" {

  rest_api_id = "${aws_api_gateway_rest_api.jobAPI.id}"
  parent_id   = "${aws_api_gateway_rest_api.jobAPI.root_resource_id}"
  path_part   = "{proxy+}"

}

resource "aws_api_gateway_method" "proxy" {

  rest_api_id   = "${aws_api_gateway_rest_api.jobAPI.id}"
  resource_id   = "${aws_api_gateway_resource.proxy.id}"
  http_method   = "ANY"
  authorization = "NONE"
  
}

resource "aws_lambda_permission" "allow_api_gateway-getActiveJobs" {
  function_name = "${aws_lambda_function.getActiveJobs.arn}"
  statement_id = "AllowExecutionFromApiGateway"
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.example_api.id}/*/${aws_api_gateway_method.example_api_method.http_method}${aws_api_gateway_resource.example_api_resource.path}"
}

resource "aws_lambda_permission" "allow_api_gateway-getAllJobs" {
  function_name = "${aws_lambda_function.getAllJobs.arn}"
  statement_id = "AllowExecutionFromApiGateway"
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.example_api.id}/*/${aws_api_gateway_method.example_api_method.http_method}${aws_api_gateway_resource.example_api_resource.path}"
}

resource "aws_lambda_permission" "allow_api_gateway-postNewJob" {
  function_name = "${aws_lambda_function.postNewJob.arn}"
  statement_id = "AllowExecutionFromApiGateway"
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.example_api.id}/*/${aws_api_gateway_method.example_api_method.http_method}${aws_api_gateway_resource.example_api_resource.path}"
}

resource "aws_lambda_permission" "allow_api_gateway-updateExistingJobs" {
  function_name = "${aws_lambda_function.updateExistingJobs.arn}"
  statement_id = "AllowExecutionFromApiGateway"
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.example_api.id}/*/${aws_api_gateway_method.example_api_method.http_method}${aws_api_gateway_resource.example_api_resource.path}"
}

resource "aws_api_gateway_resource" "getActiveJobs" {
  rest_api_id = "${aws_api_gateway_rest_api.getActiveJobs.id}"
  parent_id = "${aws_api_gateway_rest_api.getActiveJobs.root_resource_id}"
  path_part = "getActiveJobs"
}

resource "aws_api_gateway_resource" "getAllJobs" {
  rest_api_id = "${aws_api_gateway_rest_api.getAllJobs.id}"
  parent_id = "${aws_api_gateway_rest_api.getAllJobs.root_resource_id}"
  path_part = "getAllJobs"
}

resource "aws_api_gateway_resource" "postNewJob" {
  rest_api_id = "${aws_api_gateway_rest_api.postNewJob.id}"
  parent_id = "${aws_api_gateway_rest_api.postNewJob.root_resource_id}"
  path_part = "postNewJob"
}

resource "aws_api_gateway_resource" "updateExistingJobs" {
  rest_api_id = "${aws_api_gateway_rest_api.updateExistingJobs.id}"
  parent_id = "${aws_api_gateway_rest_api.updateExistingJobs.root_resource_id}"
  path_part = "updateExistingJobs"
}

resource "aws_api_gateway_method" "example_api_method" {
  rest_api_id = "${aws_api_gateway_rest_api.jobAPI.id}"
  resource_id = "${aws_api_gateway_resource.example_api_resource.id}"
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_deployment" "dev_deployment" {
  depends_on = [
    "aws_api_gateway_method.example_api_method",
    "aws_api_gateway_integration.example_api_method-integration"
  ]
  rest_api_id = "${aws_api_gateway_rest_api.example_api.id}"
  stage_name = "dev"
}