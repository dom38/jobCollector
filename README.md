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
5. Say yes to installing crypto miners on your dolla
6. Navigate to your public/private s3 buckts/index.html to see your new websites!
