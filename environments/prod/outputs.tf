output "static_website_dns" {
  value = aws_s3_bucket.www_bucket.website_endpoint
}
