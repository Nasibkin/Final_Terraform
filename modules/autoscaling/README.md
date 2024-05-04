```markdown
# Terraform Network Security and Auto Scaling Setup for AWS

## Overview
This Terraform script provisions resources for managing network security and deploying an Auto Scaling Group with an Application Load Balancer (ALB) in an AWS environment.

## Security Group Configuration
The script defines two security groups:
- **ALB Security Group:** Controls access to the ALB, allowing incoming HTTP traffic from the internet on port 80.
- **ASG Security Group:** Associated with the Auto Scaling Group (ASG), allowing incoming HTTP traffic only from the ALB security group.

## Launch Template
The Launch Template specifies the configuration for EC2 instances launched by the Auto Scaling Group. It defines the instance type, AMI ID, IAM instance profile, security group, and user data.

## Auto Scaling Group
The Auto Scaling Group manages the scaling of EC2 instances. It specifies the desired capacity, minimum and maximum size, VPC subnet identifiers, and target group ARN for the ALB.

## Application Load Balancer (ALB)
The ALB distributes incoming HTTP traffic across multiple targets. It is associated with a target group and a listener configured to forward traffic to the target group.

## User Data Configuration
The `userdata.sh` script installs and configures Apache HTTP Server (httpd) on EC2 instances launched by the Auto Scaling Group. It retrieves static website files from an S3 bucket and serves them via the web server.

## Usage
1. Modify the variables in the `variables.tf` file as needed to customize the deployment.
2. Ensure you have the necessary AWS credentials configured locally.
3. Run `terraform init` to initialize the working directory.
4. Run `terraform plan` to preview the changes.
5. Run `terraform apply` to apply the changes and provision the resources in your AWS account.

## Variables
You can customize the deployment using the following variables:
- `name`: The name prefix used for naming resources.
- `vpc_id`: The ID of the VPC where resources will be deployed.
- `default_ami_id`: The default AMI ID used for launching instances.
- `user_specified_ami_id`: The user-specified AMI ID for launching instances.
- `instance_type`: Size of EC2 Instances.
- `max_size`: The maximum number of instances in the autoscaling group.
- `min_size`: The minimum number of instances in the autoscaling group.
- `desired_capacity`: The desired capacity of instances in the autoscaling group.
- `private_subnet_ids`: The list of private subnet IDs.
- `public_subnet_ids`: The list of public subnet IDs.

Adjust these variables according to your requirements before deploying the infrastructure.

For more detailed information about each resource and variable, please refer to the respective Terraform documentation.
```
