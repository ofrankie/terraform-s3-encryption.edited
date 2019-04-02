output "DEV bucket_name" {
  value = "${aws_s3_bucket.dev-desecurebucket.id}"
}

output "QA bucket_name" {
  value = "${aws_s3_bucket.qa-desecurebucket.id}"
}


output "Prod bucket_name" {
  value = "${aws_s3_bucket.prod-desecurebucket.id}"
}
