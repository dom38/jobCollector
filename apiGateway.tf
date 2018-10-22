resource "aws_api_gateway_rest_api" "jobAPI" {

  name        = "JobBot API Gateway"
  description = "Gateway for serverless actions"
  
}