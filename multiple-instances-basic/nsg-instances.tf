
# Security Group for Public Bastion Host
module "master_nsg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "master-nsg"
  description = "Security Group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id      = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules       = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]

  tags = {
    terraform = "true"
  }
}

# Security Group for Private EC2 Instances
module "worker_nsg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "worker-nsg"
  description = "Security Group with HTTP & SSH port open for entire VPC Block (IPv4 CIDR), egress ports are all world open"
  vpc_id      = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules       = ["ssh-tcp", "http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]

  tags = {
    terraform = "true"
  }
}