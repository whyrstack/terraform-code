# Ref: https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest?tab=outputs
#

output "created_vpc_name" {
    value = module.vpc.vpc_id
}

output "created_vpc" {
    value = module.vpc.vpc_cidr_block
}

# Back-end
output "created_private_subnets" {
    value = module.vpc.private_subnets
}

# Front-end
output "created_public_subnets" {
    value = module.vpc.public_subnets
}

output "created_in_azs" {
    value = module.vpc.azs
}