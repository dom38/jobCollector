resource "aws_dynamodb_table" "job-table" {

  name = "job-table"
  read_capacity = 20
  write_capacity = 8
  hash_key = "JobID"
  range_key = "JobJSON"

  attribute {

    name = "JobID"
    type = "N"

  }

  attribute {

    name = "JobJSON"
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

  
}