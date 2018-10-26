provider "aws" {

  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"

}

variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "job-collector-state-terraform"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}