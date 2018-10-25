variable "file_path" {

  type = "string"
  description = "Filepath to zip containing python scripts"

}

variable "policy_filepath" {

  type = "list"
  description = "Filepaths to files that contain the role the lambdas will assume"

}

variable "id" {

  type = "string"
  description = "Your account ID"

}

variable "name" {

  type = "list"
  description = "List of names that your lambdas will be called"
  default = [ "GetActiveJobs", "GetAllJobs", "PostNewJob", "UpdateJob"]

}