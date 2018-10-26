resource "aws_api_gateway_rest_api" "jobAPI" {

  name        = "JobBot API Gateway"
  description = "Gateway for serverless actions"
  
}

# resource "aws_api_gateway_resource" "proxy" {

#   rest_api_id = "${aws_api_gateway_rest_api.jobAPI.id}"
#   parent_id   = "${aws_api_gateway_rest_api.jobAPI.root_resource_id}"
#   path_part   = "{proxy+}"

# }

# resource "aws_api_gateway_method" "proxy" {

#   rest_api_id   = "${aws_api_gateway_rest_api.jobAPI.id}"
#   resource_id   = "${aws_api_gateway_resource.proxy.id}"
#   http_method   = "ANY"
#   authorization = "NONE"

# }

output "rest-api-name" {
  value = "${aws_api_gateway_rest_api.jobAPI.name}"
}

output "rest_api_id" {
  value = "${aws_api_gateway_rest_api.jobAPI.id}"
}

output "root_resource_id" {
  value = "${aws_api_gateway_rest_api.jobAPI.root_resource_id}"
}