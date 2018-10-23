variable "gateway_name" {
  description = "name of the gateway the lambda functions will be deployed on"  
}

variable "file_path" {
  description = "File path to a zip of the lambda function"  
}

variable "runtime" {
  description = "Runtime of the lambda function"  
}

variable "name" {
  description = "name of the lambda function"  
}

variable "policy_name" {
  description = "name of the policy to be created for the lambda"
}

variable "policy_filepath" {
  description = "Filepath of the policy file for this lambda"
}

variable "HTTP_method" {
  description = "The HTTP method that your function will require"
}

variable "region" {
  description = "Region the resources will be raised in"
}

resource "aws_lambda_function" var.name {

  function_name = "${var.name}"
  filename      = "${var.name}"
  handler = "${var.name}.handler"
  runtime = "${var.runtime}"
  source_code_hash = "${base64sha256(file(file_path))}"
  role = "${aws_iam_role.policy_name.arn}"

  depends_on = ["aws_api_gateway_rest_api.jobAPI"]

}

resource "aws_iam_role" policy_name {

  name = "${var.policy_name}"
  assume_role_policy = "${file("policy_filepath")}"

}

resource "aws_lambda_permission" "allow_api_gateway-${var.name}" {

  function_name = "${aws_lambda_function}.${var.name}.${arn}"
  statement_id = "AllowExecutionFromApiGateway"
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api}.${var.name}.${id}/*/${aws_api_gateway_method}.${var.name}.${http_method}${aws_api_gateway_resource}.${var.name}.${path}"

}

resource "aws_api_gateway_resource" var.name {

  rest_api_id = "${aws_api_gateway_rest_api.jobAPI.id}"
  parent_id = "${aws_api_gateway_rest_api.jobAPI.root_resource_id}"
  path_part = "${var.name}"

}

resource "aws_api_gateway_method" var.name {

  rest_api_id = "${aws_api_gateway_rest_api.gateway_name.id}"
  resource_id = "${aws_api_gateway_resource}.${var.name}.${id}"
  http_method = "${var.HTTP_method}"
  authorization = "NONE"

}

resource "aws_api_gateway_integration" "${var.name}-integration" {

  rest_api_id = "${aws_api_gateway_rest_api}.${var.gateway_name}.${id}"
  resource_id = "${aws_api_gateway_resource}.${var.name}.${id}"
  http_method = "${aws_api_gateway_method}.${var.name}.${http_method}"
  type = "AWS_PROXY"
  uri = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:function:${var.name}.${var.name}.${var.name}/invocations"
  integration_http_method = "${var.HTTP_method}"

}

resource "aws_api_gateway_deployment" "${var.name}_deployment_dev" {
  # depends_on = [
  #   "aws_api_gateway_method.var.name",
  #   "aws_api_gateway_integration.${var.name}-integration"
  # ]
  rest_api_id = "${aws_api_gateway_rest_api.jobAPI.id}"
  stage_name = "dev"
}
