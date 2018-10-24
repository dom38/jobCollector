module "APIGateway" {
  source = "./modules/api-gateway"
  
}

module "lambda1" {

  source = "./modules/lambda-deployment"

  gateway_name = "${module.APIGateway.rest-api-name}"
  file_path = "lambda_function_payload.zip"
  runtime = "python3.6"
  name = "GetActiveJobs"
  policy_name = "GetActiveJobs-policy" 
  policy_filepath = "lambda-role.json"
  HTTP_method = "POST"
  region = "eu-west-1"
  id = "296929104043"
  rest_api_id = "${module.APIGateway.rest_api_id}"
  root_resource_id = "${module.APIGateway.root_resource_id}"
  
}

module "lambda2" {

  source = "./modules/lambda-deployment"

  gateway_name = "jobAPI"
  file_path = "lambda_function_payload.zip"
  runtime = "python3.6"
  name = "GetAllJobs"
  policy_name = "GetAllJobs-policy" 
  policy_filepath = "lambda-role.json"
  HTTP_method = "POST"
  region = "eu-west-1"
  id = "296929104043"
  rest_api_id = "${module.APIGateway.rest_api_id}"
  root_resource_id = "${module.APIGateway.root_resource_id}"

  
}

module "lambda3" {

  source = "./modules/lambda-deployment"

  gateway_name = "jobAPI"
  file_path = "lambda_function_payload.zip"
  runtime = "python3.6"
  name = "PostNewJob"
  policy_name = "PostNewJob-policy" 
  policy_filepath = "lambda-role.json"
  HTTP_method = "POST"
  region = "eu-west-1"
  id = "296929104043"
  rest_api_id = "${module.APIGateway.rest_api_id}"
  root_resource_id = "${module.APIGateway.root_resource_id}"
  
}

module "lambda4" {

  source = "./modules/lambda-deployment"

  gateway_name = "jobAPI"
  file_path = "lambda_function_payload.zip"
  runtime = "python3.6"
  name = "UpdateJob"
  policy_name = "UpdateJob-policy" 
  policy_filepath = "lambda-role.json"
  HTTP_method = "POST"
  region = "eu-west-1"
  id = "296929104043"
  rest_api_id = "${module.APIGateway.rest_api_id}"
  root_resource_id = "${module.APIGateway.root_resource_id}"
  
}