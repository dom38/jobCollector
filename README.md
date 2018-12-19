# Job Collector

The point of this repo is to provide a lightweight website that is completely serverless and free to use that has a DB backend and lightweight frontend. 

This example implementation is a website with a public a private entrypoint; the public point contains a form for recruiters to provide information on a role. The private point is a collection of these details with some filters for active and inactive jobs (And a mechanism for marking them as so).

# Pre-Requirements

* AWS account where you have control over everything
* AWS account Private and Secret keys in a tfvars file
* Two s3 buckets, one public and one private
* Terraform installed on your system
* (Optional) tfvars file setup the way it is included in this git repo

# Doing the thing

1. Clone this repo `git clone https://github.com/dom38/jobCollector`
2. Navigate to the cloned repo
3. Run `terraform init`
4. Run `terraform apply \ -var-file="Path/to/keys.tfvars" \ -var-file="Path/to/variables.tfvars"`
5. Put your AWS account ID in the prompt
5. Follow the outputted s3 link to the index

# TODO

* Fix the lambda/API Gateway permissioning issue 
* Insert returned API endpoints into HTML pages
* Jazz up the webpages and integrate all the lambda functions
* Stop the 8 errors on deployment