# AWS S3 Bucket Configuration

## Description
This Terraform script provisions an AWS S3 bucket for hosting a static website. It configures the bucket with website settings, public access block, and a bucket policy.

## Usage
1. Ensure you have the necessary AWS credentials configured locally.
2. Modify the `bucket_name` variable in `variables.tf` if you want to use a different bucket name.
3. Run `terraform init` to initialize the project.
4. Run `terraform plan` to preview the changes.
5. Run `terraform apply` to apply the changes and create the S3 bucket.

## Resources
- **AWS S3 Bucket**: Creates an S3 bucket for hosting a static website.
- **AWS S3 Bucket Website Configuration**: Configures the bucket with index and error documents.
- **AWS S3 Bucket Public Access Block**: Sets public access settings for the bucket.
- **AWS S3 Bucket Policy**: Defines a policy allowing public read access to objects in the bucket.

## Inputs
- `bucket_name`: The name of the bucket (default: "nasiba-final").

## Outputs
None

## Author
Created by [Nasiba]

