module "APIGateway" {
  source = "./modules/api-gateway"
  
}

module "lambda1" {

  source = "./modules/lambda-deployment"

  gateway_name = "${module.APIGateway.rest-api-name}"
  file_path = "${var.file_path}"
  runtime = "python3.6"
  name = "${var.name[0]}"
  policy_name = "${var.name[0]}-policy" 
  policy_filepath = "${var.policy_filepath[0]}"
  HTTP_method = "POST"
  region = "${var.region}"
  id = "${var.id}"
  rest_api_id = "${module.APIGateway.rest_api_id}"
  root_resource_id = "${module.APIGateway.root_resource_id}"
  
}

module "lambda2" {

  source = "./modules/lambda-deployment"

  file_path = "${var.file_path}"
  runtime = "python3.6"
  name = "${var.name[1]}"
  policy_name = "${var.name[1]}-policy" 
  policy_filepath = "${var.policy_filepath[1]}"
  HTTP_method = "POST"
  region = "${var.region}"
  id = "${var.id}"
  rest_api_id = "${module.APIGateway.rest_api_id}"
  root_resource_id = "${module.APIGateway.root_resource_id}"

  
}

module "lambda3" {

  source = "./modules/lambda-deployment"

  file_path = "${var.file_path}"
  runtime = "python3.6"
  name = "${var.name[2]}"
  policy_name = "${var.name[2]}-policy" 
  policy_filepath = "${var.policy_filepath[2]}"
  HTTP_method = "POST"
  region = "${var.region}"
  id = "${var.id}"
  rest_api_id = "${module.APIGateway.rest_api_id}"
  root_resource_id = "${module.APIGateway.root_resource_id}"
  
}

module "lambda4" {

  source = "./modules/lambda-deployment"

  file_path = "${var.file_path}"
  runtime = "python3.6"
  name = "${var.name[3]}"
  policy_name = "${var.name[3]}-policy" 
  policy_filepath = "${var.policy_filepath[3]}"
  HTTP_method = "POST"
  region = "${var.region}"
  id = "${var.id}"
  rest_api_id = "${module.APIGateway.rest_api_id}"
  root_resource_id = "${module.APIGateway.root_resource_id}"
  
}