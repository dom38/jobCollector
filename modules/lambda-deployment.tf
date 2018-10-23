variable "gateway_name" {
  description = "Name of the gateway the lambda functions will be deployed on"  
}

variable "file_path" {
  description = "File path to a zip of the lambda function"  
}

variable "runtime" {
  description = "Runtime of the lambda function"  
}

variable "name" {
  description = "Name of the lambda function"  
}

variable "policy_name" {
  description = "Name of the policy to be created for the lambda"
}

variable "policy_filepath" {
  description = "Filepath of the policy file for this lambda"
}

variable "HTTP_method" {
  description = "The HTTP method that your function will require"
}

resource "aws_lambda_function" name {

  function_name = name
  filename      = name
  handler = "${var.name}.handler"
  runtime = runtime
  source_code_hash = "${base64sha256(file(file_path))}"
  role = "${aws_iam_role.policy_name.arn}"

}

resource "aws_iam_role" policy_name {

  name = policy_name
  assume_role_policy = "${file("policy_filepath")}"

}

resource "aws_lambda_permission" "allow_api_gateway-${name}" {

  function_name = "${aws_lambda_function.name.arn}"
  statement_id = "AllowExecutionFromApiGateway"
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.name.id}/*/${aws_api_gateway_method.example_api_method.http_method}${aws_api_gateway_resource.example_api_resource.path}"

}

resource "aws_api_gateway_resource" name {

  rest_api_id = "${aws_api_gateway_rest_api.gateway_name.id}"
  parent_id = "${aws_api_gateway_rest_api.gateway_name.root_resource_id}"
  path_part = name

}

resource "aws_api_gateway_method" name {

  rest_api_id = "${aws_api_gateway_rest_api.gateway_name.id}"
  resource_id = "${aws_api_gateway_resource.name.id}"
  http_method = HTTP_method
  authorization = "NONE"

}

resource "aws_api_gateway_integration" "${name}-integration" {

  rest_api_id = "${aws_api_gateway_rest_api.gateway_name.id}"
  resource_id = "${aws_api_gateway_resource.name.id}"
  http_method = "${aws_api_gateway_method.name.http_method}"
  type = "AWS_PROXY"
  uri = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:function:${name.name.name}/invocations"
  integration_http_method = HTTP_method

}

resource "aws_api_gateway_deployment" "example_deployment_dev" {
  depends_on = [
    "aws_api_gateway_method.name",
    "aws_api_gateway_integration.${name}-integration"
  ]
  rest_api_id = "${aws_api_gateway_rest_api.example_api.id}"
  stage_name = "dev"
}
