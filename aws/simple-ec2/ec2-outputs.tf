output "ec2_global_ips" {
  value = ["${aws_instance.main.*.public_ip}"]
}

output "ec2_global_dns" {
  value = ["${aws_instance.main.*.public_dns}"]
}

output "ec2_private_ips" {
  value = ["${aws_instance.main.*.private_ip}"]
}