

resource "aws_s3_bucket_object" "private" {
  bucket = "${var.private_s3_bucket}"
  key    = "index.html"
  source = "./private_site.html"
  etag   = "${md5(file("./private_site.html"))}"
}

resource "aws_s3_bucket_object" "public" {
  bucket = "${var.public_s3_bucket}"
  key    = "index.html"
  source = "./public_site.html"
  etag   = "${md5(file("./public_site.html"))}"
}