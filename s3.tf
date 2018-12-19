
resource "aws_s3_bucket" "private_website" {

  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "form.html"

  }
}

resource "aws_s3_bucket" "public_website" {

  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "form.html"

  }
}

resource "aws_s3_bucket_object" "private" {
  bucket = "${aws_s3_bucket.private_website.id}"
  key    = "index.html"
  content_type = "text/html"
  source = "./private_site.html"
  acl = "public-read"
}

resource "aws_s3_bucket_object" "public" {
  bucket = "${aws_s3_bucket.public_website.id}"
  key    = "index.html"
  content_type = "text/html"
  source = "./public_site.html"
  acl = "public-read"
}

output "Public_Endpoint" {
  value = "Private Facing Website: ${aws_s3_bucket.public_website.website_endpoint}"
}

output "Private_Endpoint" {
  value = "Private Facing Website: ${aws_s3_bucket.private_website.website_endpoint}"
}