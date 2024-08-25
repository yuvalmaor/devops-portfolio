output "subnets_id" {
  value = aws_subnet.subnets.*.id
}

output "private_subnets_id" {
  value = aws_subnet.private_subnets.*.id
}

output "vpc_id" {
  value = aws_vpc.yuval-terraform-vpc.id
}

output "instance_sg" {
  value = aws_security_group.instance_sg
}