# Ref: https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest
# 
module "my_vpc_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.2"

  name = var.my_vpc_sg_name
  description = "Security Group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.my_vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "http-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "https-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 2049
      to_port     = 2049
      protocol    = "tcp"
      description = "efs-nfs-tcp"
      cidr_blocks = "10.10.0.0/16"
    }
  ]

  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = {
    Terraform = "true"
    Type = "network"
  }
}