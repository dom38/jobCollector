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

variable "id" {
  description = "Account_ID of the user"
}

variable "root_resource_id" {

}

variable "rest_api_id" {
  
}

resource "aws_lambda_function" "lambda" {

  function_name = "${var.name}"
  filename      = "${var.file_path}"
  handler = "${var.name}.handler"
  runtime = "${var.runtime}"
  source_code_hash = "${base64sha256(file(var.file_path))}"
  role = "${aws_iam_role.lambda-role.arn}"

}

resource "aws_iam_role" "lambda-role" {

  name = "${var.policy_name}"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com",
          "apigateway.amazonaws.com",
          "dynamodb.amazonaws.com"
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "lambda-policy" {
    name        = "${var.policy_name}"
    description = "Policy to allow lambda to connect to dynamoDB"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:BatchGetItem",
        "dynamodb:GetItem",
        "dynamodb:Query",
        "dynamodb:Scan",
        "dynamodb:BatchWriteItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda-role-attachment" {
    role       = "${aws_iam_role.lambda-role.name}"
    policy_arn = "${aws_iam_policy.lambda-policy.arn}"
}

resource "aws_lambda_permission" "lambda-permission" {

  function_name = "${aws_lambda_function.lambda.arn}"
  statement_id = "AllowExecutionFromApiGateway"
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.region}:${var.id}:${var.rest_api_id}/*/aws_api_gateway_method.${var.name}.${var.HTTP_method}${aws_api_gateway_resource.lambda-gateway-resource.path}"

}

resource "aws_api_gateway_resource" "lambda-gateway-resource" {

  rest_api_id = "${var.rest_api_id}"
  parent_id = "${var.root_resource_id}"
  path_part = "${var.name}"

}

resource "aws_api_gateway_method" "lambda-gateway-method" {

  rest_api_id = "${var.rest_api_id}"
  resource_id = "${aws_api_gateway_resource.lambda-gateway-resource.id}"
  http_method = "${var.HTTP_method}"
  authorization = "NONE"

}

resource "aws_api_gateway_integration" "lambda-gateway-integration" {

  rest_api_id = "${var.rest_api_id}"
  resource_id = "${aws_api_gateway_resource.lambda-gateway-resource.id}"
  http_method = "${aws_api_gateway_method.lambda-gateway-method.http_method}"
  type = "AWS_PROXY"
  uri = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.region}:${var.id}:function:${var.name}.${var.name}.${var.name}/invocations"
  integration_http_method = "${var.HTTP_method}"

}

resource "aws_api_gateway_deployment" "lambda-gateway-deployment" {

  depends_on = ["aws_api_gateway_integration.lambda-gateway-integration"]
  rest_api_id = "${var.rest_api_id}"
  stage_name = "dev"

}
