# Ref: https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest
# 
module "my_vpc_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.2"

  name = var.my_vpc_sg_name
  description = "Security Group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.my_vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = {
    Terraform = "true"
    Type = "network"
  }
}