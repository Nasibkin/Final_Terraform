module "networking" {
  source        = "../../modules/networking"
  vpc_cidr      = "12.0.0.0/16"
  name          = "nasiba"
  public_cidrs  = ["12.0.1.0/24", "12.0.2.0/24", "12.0.3.0/24"]
  private_cidrs = ["12.0.4.0/24", "12.0.5.0/24", "12.0.6.0/24"]
}

module "autoscaling" {
  source                = "../../modules/autoscaling"
  depends_on            = [module.networking]
  name                  = "Final-Project"
  user_specified_ami_id = data.aws_ami.amazon-linux.id
  vpc_id                = module.networking.vpc_id
  public_subnet_ids     = values(module.networking.public_subnet_ids)
  private_subnet_ids    = values(module.networking.private_subnet_ids)
  max_size              = 8
  min_size              = 2
  desired_capacity      = 4
}
