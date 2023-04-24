# Ref: https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
#
module "my_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"

  name = var.my_vpc_name
  cidr = var.my_vpc_cidr

  azs             = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  private_subnets = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"] # Backend subnets
  public_subnets  = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"] # Frontend subnets

  enable_nat_gateway = false
  enable_vpn_gateway = false

  enable_dns_support = true
  enable_dhcp_options = true

  tags = {
    Terraform = "true"
    Type = "network"
  }
}