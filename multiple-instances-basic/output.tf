## INSTANCES
output "get_private_ips_masters" {
  value = module.master_nodes.*.private_ip
}

output "get_hostnames_masters" {
  value = module.master_nodes.*.private_dns
}

output "get_public_ips_masters" {
  value = aws_eip.master_eips.*.public_ip
}

output "get_private_ips_workers" {
  value = module.worker_nodes.*.private_ip
}

output "get_hostnames_workers" {
  value = module.worker_nodes.*.private_dns
}

output "get_public_ips_workers" {
  value = aws_eip.worker_eips.*.public_ip
}

## LOAD BALANCER
output "get_elb_hostname" {
  value = module.elb.*.this_elb_dns_name
}
