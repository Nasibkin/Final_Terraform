output "alb_dns_name" {
  value = module.autoscaling.alb_public_url
}
