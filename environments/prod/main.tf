# Define AWS provider
provider "aws" {
  region = "us-east-1"  # Update with your desired region
}

# Create an S3 bucket for hosting the static website
resource "aws_s3_bucket" "static_website_bucket" {
  bucket = "your-unique-bucket-name"  # Update with your preferred bucket name
  acl    = "public-read"              # Set bucket ACL to allow public read access

  website {
    index_document = "index.html"      # Specify the index document for the website
  }
}

# Output the DNS name of the static website
output "website_dns_name" {
  value = aws_s3_bucket.static_website_bucket.website_endpoint
}
