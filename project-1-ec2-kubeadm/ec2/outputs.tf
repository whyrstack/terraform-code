output "my_public_ips" {
    #value = module.ec2_instance.public_ip
    value = [for s in module.ec2_instance : s.public_ip]
  
}

output "my_private_ips" {
    #value = module.ec2_instance.private_ip
    value = [for s in module.ec2_instance : s.private_ip]
}



/*
# AMI ID
output "my_ami" {
    value = data.aws_ami.amzlinux2.id
}

# Availability zones
output "my_azs" {
    value = data.aws_availability_zones.available.names
}

# Security groups

output "my_sgs" {
    value = data.aws_security_groups.selected.ids
}
# VPC details
output "my_vpcs" {
    value = data.aws_vpcs.vpc.ids
}

# public subnet details
output "my_public_subnets" {
    value = data.aws_subnets.subnets_public.ids
}

# private subnet details
output "my_private_subnets" {
    value = data.aws_subnets.subnets_private.ids
}

*/