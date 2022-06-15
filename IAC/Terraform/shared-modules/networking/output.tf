output "subnet_id" {
  value = aws_subnet.node.id
}

output "vpc_id" {
  value = "${aws_vpc.node.id}"
}