output "bastion_pub_ip" {
  value       = aws_instance.bastion.public_ip
  description = "public IP of bastion host"
}

output "private-ips" {
  value = "${data.aws_instances.nodes.private_ips}"
}
