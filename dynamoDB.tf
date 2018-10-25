resource "aws_dynamodb_table" "job-table" {

  name = "job-table"
  read_capacity = 8
  write_capacity = 8
  hash_key = "jobID"

  attribute {

    name = "jobID"
    type = "N"

  }

  ttl {

    attribute_name = "TimeToExist"
    enabled = false

  }

  tags {

    Name        = "job-table"
    Environment = "Development"

  }

  
}