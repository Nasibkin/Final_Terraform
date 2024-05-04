# Terraform Networking Infrastructure

## Project Description

This project aims to create network infrastructure using Terraform. It includes setting up public and private subnets, as well as implementing a NAT Gateway to provide private resources with internet access.

## Project Structure

├── main.tf  
├── variables.tf  
├── README.md  
└── outputs.tf  

- `main.tf`: Main Terraform configuration file containing resources for creating VPC, subnets, route tables, and NAT Gateway.
- `variables.tf`: File declaring variables used in the Terraform configuration.
- `README.md`: This file, containing the project description and instructions for usage.
- `outputs.tf`: File containing outputs used to display information after applying Terraform configuration.

## Usage

1. Install Terraform if it's not already installed on your machine.
2. Create a `terraform.tfvars` file and specify variable values if they differ from the defaults.
3. Run `terraform init` command to initialize the project.
4. Run `terraform plan` command to review the planned changes.
5. Run `terraform apply` command to apply the changes and create the infrastructure.

To customize your network configuration, you can specify the following variables when running `terraform apply`:

- `vpc_cidr`: CIDR block for the VPC.
- `name`: Project name.
- `public_cidrs`: List of CIDR blocks for public subnets.

Example:
```bash
terraform apply -var="vpc_cidr=10.0.0.0/16" -var="name=men" -var="public_cidrs=[\"10.0.1.0/24\", \"10.0.2.0/24\", \"10.0.3.0/24\"]"

Variables
vpc_cidr: CIDR block for the VPC (default: "17.0.0.0/16").
name: Project name (default: "nasiba").
public_cidrs: List of CIDR blocks for public subnets (default: ["17.0.1.0/24", "17.0.2.0/24"]).
private_cidrs: List of CIDR blocks for private subnets (default: ["17.0.3.0/24", "17.0.4.0/24"]).
Resources
aws_vpc: Creates a virtual private cloud (VPC).
aws_internet_gateway: Creates an internet gateway for internet access from the VPC.
aws_subnet: Creates subnets within the VPC.
aws_route_table: Creates route tables for routing traffic within the VPC.
aws_nat_gateway: Creates a NAT Gateway to provide private resources with internet access.

Additional Information
For more information on Terraform and AWS, refer to the Terraform official documentation and AWS documentation.