#
# Get latest AMI ID for Amazon Linux2 OS
data "aws_ami" "amzlinux2" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}
# 
# Declare the data source for availability zones
data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "zone-name"
    values = ["eu-central-1a", "eu-central-1b"]
  }
}
# 
# Declare the data source for security groups
data "aws_security_groups" "selected" {
    filter {
      name = "group-name"
      values = ["myVPCsg*"]
    }
}
# 
# Declare the data source for vpcs
data "aws_vpcs" "vpc" {  
    tags = {
      Name = "myVPC"
  }
}
# 
# Declare the data source for public subnets
data "aws_subnets" "subnets_public" {
    tags = {
      Name = "myVPC-public*"
    }
}

# 
# Declare the data source for private subnets
data "aws_subnets" "subnets_private" {
    tags = {
      Name = "myVPC-private*"
    }
}
/*
# KMS key 
data "aws_kms_key" "by_alias" {
  key_id = "alias/my-kms-key"
}
*/