
resource "aws_s3_bucket" "website" {

  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "form.html"

  }
}

resource "aws_s3_bucket_object" "private" {
  bucket = "${aws_s3_bucket.website.id}"
  key    = "index.html"
  content_type = "text/html"
  source = "./private_site.html"
  acl = "public-read"
}

resource "aws_s3_bucket_object" "public" {
  bucket = "${aws_s3_bucket.website.id}"
  key    = "form.html"
  content_type = "text/html"
  source = "./public_site.html"
  acl = "public-read"
}

output "Endpoint" {
  value = "${aws_s3_bucket.website.website_endpoint}"
}