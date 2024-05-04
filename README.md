## Terraform Readme

### Overview

This Terraform script provisions networking resources and sets up an Auto Scaling Group (ASG) with an Application Load Balancer (ALB) in an AWS environment. It utilizes two custom modules: `networking` and `autoscaling`.

### Usage

1. **Clone Repository**: Clone this repository to your local machine.
2. **Module Configuration**:
   - Open the main Terraform configuration file (`main.tf`) in your preferred text editor.
   - Configure the `networking` module by specifying the VPC CIDR, name, and CIDRs for public and private subnets.
   - Configure the `autoscaling` module by specifying the desired parameters such as the ASG name, VPC ID, subnet IDs, and capacity settings. Make sure to provide your S3 bucket name and the path to your `index.html` file in the userdata script.
3. **Variables**:
   - Optionally, customize the variables in the `variables.tf` file to suit your requirements.
   - You can input your own variables for customization according to your AWS environment.
4. **Provider Configuration**:
   - Ensure you have the necessary AWS credentials configured locally. You can set up AWS credentials using environment variables or AWS CLI configuration.
   - Update the `region` parameter in the provider block if necessary.
5. **Terraform Commands**:
   - Run `terraform init` to initialize the working directory.
   - Run `terraform plan` to preview the changes.
   - Run `terraform apply` to apply the changes and provision the resources in your AWS account.
6. **Access Outputs**:
   - After successful provisioning, Terraform will output the ALB DNS name (`alb_dns_name`) which you can use to access your application.

### Modules

#### Networking Module

The `networking` module provisions VPC, subnets, route tables, internet gateway, NAT gateway, and associated resources. It allows customization of VPC CIDR, subnet CIDRs, and VPC name.

#### Autoscaling Module

The `autoscaling` module sets up an Auto Scaling Group with an Application Load Balancer. It depends on the `networking` module for VPC and subnet configurations. You can customize ASG parameters such as capacity settings, instance type, and ALB listener configuration.

### Customization

You can customize the deployment by adjusting the following parameters:

- **VPC and Subnet Configuration**: Modify VPC CIDR, subnet CIDRs, and VPC name in the `networking` module configuration.
- **Auto Scaling Group Configuration**: Customize ASG parameters such as capacity settings, instance type, and ALB listener configuration in the `autoscaling` module configuration. Ensure to specify your S3 bucket name and the path to your `index.html` file in the userdata script.
- **AWS Provider Configuration**: Update the AWS region in the provider block if necessary.

### Additional Information

For more detailed information about each resource and variable, please refer to the respective Terraform documentation.

### Note

Ensure you have appropriate permissions and adhere to AWS best practices while provisioning resources. Review the Terraform execution plan carefully before applying changes to avoid unexpected modifications.