resource "aws_security_group" "main" {
  name = "ssh"
  vpc_id = "${aws_vpc.main-node.id}"
}

resource "aws_security_group_rule" "ssh" {
  type            = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.main.id}"
}

resource "aws_security_group_rule" "bootnode" {
  for_each = toset(var.public-ports)  
  type            = "ingress"
  from_port       = each.key
  to_port         = each.key
  protocol        = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.main.id}"
}

resource "aws_security_group_rule" "vpn" {
  type            = "ingress"
  from_port       = 51820
  to_port         = 51820
  protocol        = "udp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.main-node.id}"
}

resource "aws_security_group_rule" "node-exporter" {
  for_each = toset(var.metrics-ports)     
  type            = "ingress"
  from_port       = each.key
  to_port         = each.key
  protocol        = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.main-node.id}"
}

resource "aws_security_group_rule" "allow_all-node" {
  type            = "egress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.main-node.id}"
}