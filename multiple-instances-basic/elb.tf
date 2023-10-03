# Terraform AWS Classic Load Balancer (ELB-CLB)
module "elb" {
  source  = "terraform-aws-modules/elb/aws"
  version = "~> 2.0"

  name    = "k8s-elb"
  subnets = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1]
  ]
  security_groups = [module.loadbalancer_nsg.security_group_id]
  #internal        = false

  listener = [
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 80
      lb_protocol       = "HTTP"
    },
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 81
      lb_protocol       = "HTTP"
    },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  # ELB attachments
  number_of_instances = 2
  instances = module.worker_nodes.*.id

  tags = {
    terraform = "true"
  }
}