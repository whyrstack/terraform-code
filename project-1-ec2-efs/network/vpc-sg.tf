# Ref: https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/1.19.0
#
module "my_vpc_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "1.19.0"

  name        = var.my_vpc_sg_name
  description = "Security group for user-service with custom ports open within VPC"
  vpc_id      = module.my_vpc.vpc_id

  ingress_cidr_blocks      = var.my_vpc_cidr
  # Ingress Allow SSH from anywhere
  ingress_rules = ["ssh-tcp"]
  ingress_with_cidr_blocks = ["0.0.0.0/0"]
  # Egress allow all
  egress_rules = ["all-all"]
  tags = {
    Terraform = true
    Type = network
  }
}