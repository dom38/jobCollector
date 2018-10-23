resource "aws_dynamodb_table" "job-table" {

  name = "job-table"
  read_capacity = 8
  write_capacity = 8
  hash_key = "JobID"
  range_key = "JobJSON"

  attribute {

    name = "JobID"
    type = "S"

  }

  attribute {

    name = "active"
    type = "S"

  }

  ttl {

    attribute_name = "TimeToExist"
    enabled = false

  }

  tags {

    Name        = "job-table"
    Environment = "Development"

  }

  global_secondary_index {

    name               = "ActiveIndex"
    hash_key           = "active"
    range_key          = "JobID"
    write_capacity     = 8
    read_capacity      = 8
    projection_type    = "INCLUDE"
    non_key_attributes = ["JobID"]
  
  }

  
}