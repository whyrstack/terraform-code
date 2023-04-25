locals {
    virtual_machines = {
        "vm1" = { ami = data.aws_ami.amzlinux2.id, instance_type = "t2.medium", availability_zone = data.aws_availability_zones.available.names[0], instance_count = 1, subnet_ids = data.aws_subnets.subnets_public.ids[0], vpc_security_group_ids = data.aws_security_groups.selected.ids }#,
        #"vm2" = { ami = data.aws_ami.amzlinux2.id, instance_type = "t2.micro", availability_zone = data.aws_availability_zones.available.names[1], instance_count = 1, subnet_ids = data.aws_subnets.subnets_public.ids[1], vpc_security_group_ids = data.aws_security_groups.selected.ids }
    }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.5.0"

  for_each = local.virtual_machines

  name = each.key
  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  key_name               = var.my_ssh_key
  vpc_security_group_ids = each.value.vpc_security_group_ids
  subnet_id              = each.value.subnet_ids
  user_data              = file("${path.module}/startup-script.sh")    

  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    Service = "test-service"
  }
}