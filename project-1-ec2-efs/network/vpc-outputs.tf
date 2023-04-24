# Ref: https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest?tab=outputs
#

output "created_vpc_name" {
    value = module.my_vpc.vpc_id
}

output "created_vpc" {
    value = module.my_vpc.vpc_cidr_block
}

# Back-end
output "created_private_subnets" {
    value = module.my_vpc.private_subnets
}

# Front-end
output "created_public_subnets" {
    value = module.my_vpc.public_subnets
}

output "created_in_azs" {
    value = module.my_vpc.azs
}