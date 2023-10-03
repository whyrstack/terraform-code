# Create Elastic IP for Master and Worker Nodes
resource "aws_eip" "master_eips" {

  depends_on = [module.master_nodes, module.vpc]

  count = 2

  instance = element(module.master_nodes.*.id, count.index)
  domain   = "vpc"

  tags = {
    terraform = "true"
  }
}

resource "aws_eip" "worker_eips" {

  depends_on = [module.worker_nodes, module.vpc]

  count = 2

  instance = element(module.worker_nodes.*.id, count.index)
  domain   = "vpc"

  tags = {
    terraform = "true"
  }
}