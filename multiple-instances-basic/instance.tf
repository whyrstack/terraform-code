## Associate local SSH Public key
resource "aws_key_pair" "local_key" {
  key_name   = "terraform-demo"
  public_key = file("${path.module}/id_rsa.pub")
}

# AWS EC2 Instance Terraform Module
# Bastion Host - EC2 Instance that will be created in VPC Public Subnet
module "master_nodes" {

  depends_on = [module.vpc]

  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.5.0"

  user_data = <<-EOF
    #!/bin/bash
    sudo hostnamectl set-hostname master-node
    sudo apt update -y
    sudo apt install curl wget -y
  EOF

  count = 2

  name                   = "master-${count.index}"
  ami                    = data.aws_ami.ubuntu_server.id
  instance_type          = "t2.medium"
  key_name               = aws_key_pair.local_key.key_name
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.master_nsg.security_group_id]

  tags = {
    terraform = "true"
  }
}

module "worker_nodes" {
  depends_on = [module.vpc]

  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.5.0"

  user_data = <<-EOF
    #!/bin/bash
    sudo hostnamectl set-hostname worker-node
    sudo apt update -y
    sudo apt install nginx curl wget -y
    sudo echo "Hello World... This is: $(hostname) on $(hostname -i)" | sudo tee /var/www/html/index.html
    rm -rf /var/www/html/index.nginx-debian.html
    sudo systemctl restart nginx
  EOF

  count = 2

  name                   = "worker-${count.index}"
  ami                    = data.aws_ami.ubuntu_server.id
  instance_type          = "t2.medium"
  key_name               = aws_key_pair.local_key.key_name
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.worker_nsg.security_group_id]

  tags = {
    terraform = "true"
  }
}